//
//  NetworkManager.swift
//  TestWorldClassSaratov
//
//  Created by Наташа Спиридонова on 18.05.2025.
//

import Foundation

// MARK: - NetworkError
enum NetworkError: Error {
    case invalidURL
    case decodingError
    case noData
    case badServerResponse
}

// MARK: - NetworkManager
final class NetworkService {
    
    // MARK: - Singleton
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchQuestions() async throws -> [Question] {
        guard let url = URL(string: QuestionAPI.baseURL.url) else {
            throw NetworkError.invalidURL
        }
        
        let (data, responce) = try await URLSession.shared.data(from: url)
        guard let httpResponce = responce as? HTTPURLResponse, 200..<300 ~= httpResponce.statusCode else {
            throw NetworkError.badServerResponse
        }
        
        do {
            return try JSONDecoder().decode([Question].self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
