//
//  NetworkManager.swift
//  TestWorldClassSaratov
//
//  Created by Наташа Спиридонова on 18.05.2025.
//

import Foundation

// MARK: - NetworkError
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case decodingError
    case noData
    case badServerResponse
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NetworkConfiguration.ErrorMessages.invalidURL
        case .badServerResponse:
            return NetworkConfiguration.ErrorMessages.badServerResponse
        case .decodingError:
            return NetworkConfiguration.ErrorMessages.decodingError
        case .noData:
            return NetworkConfiguration.ErrorMessages.noData
        case .networkError(let error):
            return "\(NetworkConfiguration.ErrorMessages.networkError): \(error.localizedDescription)"
        }
    }
}

// MARK: - NetworkService
final class NetworkService {
    
    // MARK: - Properties
    static let shared = NetworkService()
    
    // MARK: - Initialization
    private init() {}
    
    // MARK: - Generic Fetch Method
    private func fetchQuestions(from endpoint: String) async throws -> [Question] {
        let fullURL = "\(NetworkConfiguration.API.baseURL)\(endpoint)"
        
        guard let url = URL(string: fullURL) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  NetworkConfiguration.HTTP.successStatusCodeRange ~= httpResponse.statusCode else {
                throw NetworkError.badServerResponse
            }
            
            // Декодируем как QuestionsResponse, а не как массив
            let questionsResponse = try JSONDecoder().decode(QuestionsResponse.self, from: data)
            
            // Извлекаем вопросы по типу направления из endpoint
            let directionType = extractDirectionType(from: endpoint)
            return questionsResponse.questions(for: directionType)
            
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.networkError(error)
        }
    }
    
    // MARK: - Helper Methods
    private func extractDirectionType(from endpoint: String) -> DirectionType {
        // Извлекаем тип направления из endpoint (например, "/gym" -> .gym)
        let cleanEndpoint = endpoint.replacingOccurrences(of: "/", with: "")
        
        switch cleanEndpoint {
        case "general": return .general
        case "gym": return .gym
        case "group": return .group
        case "water": return .water
        case "manager": return .manager
        case "kids": return .kids
        default: return .general // fallback
        }
    }
}

// MARK: - NetworkService Extension
extension NetworkService {
    
    /// Получение вопросов по типу направления
    func fetchQuestions(for directionType: DirectionType) async throws -> [Question] {
        let endpoint = NetworkConfiguration.Endpoints.endpoint(for: directionType)
        return try await fetchQuestions(from: endpoint)
    }
}
