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
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    // MARK: - Initialization
    private init() {
        self.urlSession = NetworkConfiguration.createURLSession()
        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    // MARK: - Generic Fetch Method
    private func fetchQuestions(from endpoint: String) async throws -> [Question] {
        let fullURL = "\(NetworkConfiguration.API.fullBaseURL)\(endpoint)"
        
        guard let url = URL(string: fullURL) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await urlSession.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  NetworkConfiguration.HTTP.successStatusCodeRange ~= httpResponse.statusCode else {
                throw NetworkError.badServerResponse
            }
            
            return try jsonDecoder.decode([Question].self, from: data)
            
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.networkError(error)
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
    
    /// Получение вопросов по направлению фитнеса
    func fetchQuestions(for direction: FitnessDirection) async throws -> [Question] {
        return try await fetchQuestions(for: direction.type)
    }
}
