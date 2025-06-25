//
//  FitnessDirection.swift
//  TestWorldClassSaratov
//
//  Created by Наташа Спиридонова on 23.06.2025.
//

import Foundation

// MARK: - DirectionType
enum DirectionType: String, CaseIterable {
    case general = "general"
    case gym = "gym"
    case group = "group"
    case water = "water"
    case manager = "manager"
    case kids = "kids"
    
    var displayName: String {
        switch self {
        case .general: return "Общие вопросы"
        case .gym: return "Тренажерный зал"
        case .group: return "Групповые программы"
        case .water: return "Водные программы"
        case .manager: return "Вопросы от управляющего"
        case .kids: return "Детский фитнес"
        }
    }
    
    var description: String {
        switch self {
        case .general: return "Базовые знания о фитнесе, питании и здоровом образе жизни"
        case .gym: return "Тренировки на тренажерах, со свободными весами и в функциональной зоне"
        case .group: return "Тренировки в группе под руководством профессионального тренера"
        case .water: return "Тренировки в бассейне для всех уровней подготовки"
        case .manager: return "Ключевые вопросы по управлению фитнес-клубом"
        case .kids: return "Специальные программы для детей разных возрастных групп"
        }
    }
    
    var icon: String {
        switch self {
        case .general: return "heart.fill"
        case .gym: return "dumbbell.fill"
        case .group: return "person.3.fill"
        case .water: return "figure.pool.swim"
        case .manager: return "person.fill.checkmark"
        case .kids: return "figure.child"
        }
    }
}

// MARK: - FitnessDirection
struct FitnessDirection: Identifiable {
    // MARK: - Properties
    let id: Int
    let type: DirectionType
    let name: String
    let description: String
    let icon: String
    
    // MARK: - Computed Properties
    var endpoint: String {
        return "/\(type.rawValue)"
    }
    
    // MARK: - Static Properties
    static let directions: [FitnessDirection] = [
        // MARK: - General Questions
        FitnessDirection(
            id: 1,
            type: .general,
            name: "Общие вопросы",
            description: "Базовые знания о фитнесе, питании и здоровом образе жизни",
            icon: "heart.fill"
        ),
        // MARK: - Gym
        FitnessDirection(
            id: 2,
            type: .gym,
            name: "Тренажерный зал",
            description: "Тренировки на тренажерах, со свободными весами и в функциональной зоне",
            icon: "dumbbell.fill"
        ),
        // MARK: - Group Programs
        FitnessDirection(
            id: 3,
            type: .group,
            name: "Групповые программы",
            description: "Тренировки в группе под руководством профессионального тренера",
            icon: "person.3.fill"
        ),
        // MARK: - Water Programs
        FitnessDirection(
            id: 4,
            type: .water,
            name: "Водные программы",
            description: "Тренировки в бассейне для всех уровней подготовки",
            icon: "figure.pool.swim"
        ),
        // MARK: - Kids Fitness
        FitnessDirection(
            id: 5,
            type: .kids,
            name: "Детский фитнес",
            description: "Специальные программы для детей разных возрастных групп",
            icon: "figure.child"
        ),
        // MARK: - Manager Questions
        FitnessDirection(
            id: 6,
            type: .manager,
            name: "Вопросы от управляющего",
            description: "Ключевые вопросы по управлению фитнес-клубом",
            icon: "person.fill.checkmark"
        )
    ]
    
    // MARK: - Helper Methods
    static func direction(for type: DirectionType) -> FitnessDirection? {
        return directions.first { $0.type == type }
    }
}
