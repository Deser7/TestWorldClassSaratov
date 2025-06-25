//
//  TestConfiguration.swift
//  TestWorldClassSaratov
//
//  Created by Наташа Спиридонова on 18.05.2025.
//

import Foundation

// MARK: - TestConfiguration
/// Конфигурация для тестов
final class TestConfiguration {
    
    // MARK: - Time Limits (в секундах)
    struct TimeLimits {
        static let general: TimeInterval = 30 * 60  // 30 минут
        static let manager: TimeInterval = 10 * 60  // 10 минут
        static let gym: TimeInterval = 25 * 60      // 25 минут
        static let group: TimeInterval = 20 * 60    // 20 минут
        static let water: TimeInterval = 20 * 60    // 20 минут
        static let kids: TimeInterval = 15 * 60     // 15 минут
        
        /// Получение лимита времени по типу направления
        static func timeLimit(for directionType: DirectionType) -> TimeInterval {
            switch directionType {
            case .general: return general
            case .manager: return manager
            case .gym: return gym
            case .group: return group
            case .water: return water
            case .kids: return kids
            }
        }
    }
    
    // MARK: - Timer Configuration
    struct Timer {
        static let interval: TimeInterval = 1.0
        static let updateFrequency: TimeInterval = 1.0
    }
    
    // MARK: - Test Behavior
    struct Behavior {
        static let shuffleQuestionsOnLoad = true
        static let shuffleQuestionsOnReset = true
        static let shuffleAnswersOnLoad = true
        static let shuffleAnswersOnReset = true
    }
} 