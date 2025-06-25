//
//  ResultViewModel.swift
//  TestWorldClassSaratov
//
//  Created by Наташа Спиридонова on 21.06.2025.
//

import Foundation
import Observation

// MARK: - ResultViewModel
@Observable final class ResultViewModel {
    
    // MARK: - Properties
    let score: Int
    let totalQuestions: Int
    let correctAnswers: Int
    let directionName: String
    let timeSpent: TimeInterval
    
    // MARK: - Computed Properties
    var percentage: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(correctAnswers) / Double(totalQuestions) * 100
    }
    
    var isPassed: Bool {
        percentage >= 70.0 // Проходной балл 70%
    }
    
    var grade: String {
        switch percentage {
        case 90...100: return "Отлично"
        case 80..<90: return "Хорошо"
        case 70..<80: return "Удовлетворительно"
        default: return "Неудовлетворительно"
        }
    }
    
    var formattedTimeSpent: String {
        let minutes = Int(timeSpent) / 60
        let seconds = Int(timeSpent) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // MARK: - Initialization
    init(score: Int, totalQuestions: Int, correctAnswers: Int, directionName: String, timeSpent: TimeInterval) {
        self.score = score
        self.totalQuestions = totalQuestions
        self.correctAnswers = correctAnswers
        self.directionName = directionName
        self.timeSpent = timeSpent
    }
    
    // MARK: - Public Methods
    func getResultMessage() -> String {
        if isPassed {
            return "Поздравляем! Вы успешно прошли тест по направлению '\(directionName)'"
        } else {
            return "К сожалению, вы не прошли тест. Попробуйте еще раз!"
        }
    }
    
    func getDetailedResult() -> String {
        return """
        Направление: \(directionName)
        Правильных ответов: \(correctAnswers) из \(totalQuestions)
        Процент выполнения: \(Int(percentage))%
        Оценка: \(grade)
        Время выполнения: \(formattedTimeSpent)
        """
    }
}
