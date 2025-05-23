import Foundation

// MARK: - FitnessDirection
struct FitnessDirection: Identifiable {
    // MARK: - Properties
    let id: Int
    let name: String
    let description: String
    let icon: String
    let testFileName: String
    
    // MARK: - Static Properties
    static let directions: [FitnessDirection] = [
        // MARK: - General Questions
        FitnessDirection(
            id: 1,
            name: "Общие вопросы",
            description: "Базовые знания о фитнесе, питании и здоровом образе жизни",
            icon: "heart.fill",
            testFileName: "general_questions"
        ),
        // MARK: - Gym
        FitnessDirection(
            id: 2,
            name: "Тренажерный зал",
            description: "Тренировки на тренажерах, со свободными весами и в функциональной зоне",
            icon: "dumbbell.fill",
            testFileName: "gym_test"
        ),
        // MARK: - Group Programs
        FitnessDirection(
            id: 3,
            name: "Групповые программы",
            description: "Тренировки в группе под руководством профессионального тренера",
            icon: "person.3.fill",
            testFileName: "group_questions"
        ),
        // MARK: - Water Programs
        FitnessDirection(
            id: 4,
            name: "Водные программы",
            description: "Тренировки в бассейне для всех уровней подготовки",
            icon: "figure.pool.swim",
            testFileName: "water_questions"
        ),
        // MARK: - Kids Fitness
        FitnessDirection(
            id: 5,
            name: "Детский фитнес",
            description: "Специальные программы для детей разных возрастных групп",
            icon: "figure.child",
            testFileName: "kids_questions"
        ),
        // MARK: - Manager Questions
        FitnessDirection(
            id: 6,
            name: "Вопросы от управляющего",
            description: "Ключевые вопросы по управлению фитнес-клубом",
            icon: "person.fill.checkmark",
            testFileName: "manager_questions"
        )
    ]
} 
