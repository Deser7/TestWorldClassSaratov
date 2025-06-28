//
//  NetworkConfiguration.swift
//  TestWorldClassSaratov
//
//  Created by Наташа Спиридонова on 18.05.2025.
//

import Foundation

// MARK: - NetworkConfiguration
/// Конфигурация для сетевых запросов
final class NetworkConfiguration {
    
    // MARK: - API Configuration
    struct API {
        static let baseURL = "https://world-class-json-api.onrender.com/questions"
    }
    
    // MARK: - HTTP Configuration
    struct HTTP {
        static let successStatusCodeRange = 200..<300
        static let timeoutInterval: TimeInterval = 30.0
        static let cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData
    }
    
    // MARK: - Endpoints Configuration
    struct Endpoints {
        static let general = "/general"
        static let gym = "/gym"
        static let group = "/group"
        static let water = "/water"
        static let manager = "/manager"
        static let kids = "/kids"
        
        /// Получение endpoint по типу направления
        static func endpoint(for directionType: DirectionType) -> String {
            switch directionType {
            case .general: return general
            case .gym: return gym
            case .group: return group
            case .water: return water
            case .manager: return manager
            case .kids: return kids
            }
        }
    }
    
    // MARK: - Error Messages
    struct ErrorMessages {
        static let invalidURL = "Неверный URL для загрузки вопросов"
        static let badServerResponse = "Ошибка сервера при загрузке вопросов"
        static let decodingError = "Ошибка обработки данных с сервера"
        static let noData = "Данные не получены от сервера"
        static let networkError = "Ошибка сети при загрузке данных"
    }
} 
