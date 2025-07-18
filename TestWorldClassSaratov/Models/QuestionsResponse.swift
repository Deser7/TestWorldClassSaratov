//
//  QuestionsResponse.swift
//  TestWorldClassSaratov
//
//  Created by Наташа Спиридонова on 23.06.2025.
//


import Foundation

// MARK: - QuestionsResponse
struct QuestionsResponse: Codable {
    let general: [Question]?
    let manager: [Question]?
    let water: [Question]?
    let group: [Question]?
    let gym: [Question]?
    let kids: [Question]?
    
    func questions(for testType: DirectionType) -> [Question] {
        switch testType {
        case .general:
            return general ?? []
        case .manager:
            return manager ?? []
        case .water:
            return water ?? []
        case .group:
            return group ?? []
        case .gym:
            return gym ?? []
        case .kids:
            return kids ?? []
        }
    }
}
