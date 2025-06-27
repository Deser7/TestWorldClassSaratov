//
//  NetworkServiceExamples.swift
//  TestWorldClassSaratov
//
//  Created by Наташа Спиридонова on 18.05.2025.
//
//  📚 ДОКУМЕНТАЦИЯ И ПРИМЕРЫ ИСПОЛЬЗОВАНИЯ
//  Этот файл содержит примеры использования NetworkService и других компонентов приложения.
//  Предназначен для разработки, тестирования и обучения.
//  НЕ включается в production сборки.
//

import Foundation

// MARK: - NetworkService Examples
/// Примеры использования NetworkService для получения вопросов по направлениям
/// 
/// Этот класс демонстрирует:
/// - Правильные паттерны работы с NetworkService
/// - Создание и использование TestViewModel
/// - Обработку ошибок сети
/// - Интеграцию с UI компонентами
final class NetworkServiceExamples {
    
    // MARK: - Properties
    private let networkService = NetworkService.shared
    
    // MARK: - Example Methods
    
    /// Пример получения вопросов по типу направления
    func fetchQuestionsByDirectionType() async {
        do {
            // Получаем вопросы для тренажерного зала
            let gymQuestions = try await networkService.fetchQuestions(for: .gym)
            print("Загружено \(gymQuestions.count) вопросов для тренажерного зала")
            
            // Получаем вопросы для групповых программ
            let groupQuestions = try await networkService.fetchQuestions(for: .group)
            print("Загружено \(groupQuestions.count) вопросов для групповых программ")
            
        } catch {
            print("Ошибка загрузки вопросов: \(error)")
        }
    }
    
    /// Пример получения вопросов по объекту направления
    func fetchQuestionsByDirection() async {
        do {
            // Получаем направление "Тренажерный зал"
            guard let gymDirection = FitnessDirection.direction(for: .gym) else {
                print("Направление не найдено")
                return
            }
            
            // Получаем вопросы для этого направления
            let questions = try await networkService.fetchQuestions(for: gymDirection)
            print("Загружено \(questions.count) вопросов для направления: \(gymDirection.name)")
            
        } catch {
            print("Ошибка загрузки вопросов: \(error)")
        }
    }
    
    /// Пример загрузки всех направлений
    func fetchAllDirections() async {
        do {
            var allQuestions: [DirectionType: [Question]] = [:]
            
            // Загружаем вопросы для всех направлений
            for directionType in DirectionType.allCases {
                let questions = try await networkService.fetchQuestions(for: directionType)
                allQuestions[directionType] = questions
                print("\(directionType.displayName): \(questions.count) вопросов")
            }
            
            print("Всего загружено направлений: \(allQuestions.count)")
            
        } catch {
            print("Ошибка загрузки всех направлений: \(error)")
        }
    }
    
    /// Пример создания TestViewModel для конкретного направления
    func createTestViewModel() {
        // Создаем TestViewModel для тренажерного зала
        let gymTestViewModel = TestViewModel(directionType: .gym)
        
        // Создаем TestViewModel для детского фитнеса
        let kidsTestViewModel = TestViewModel(directionType: .kids)
        
        // Создаем TestViewModel для вопросов управляющего
        let managerTestViewModel = TestViewModel(directionType: .manager)
        
        print("Созданы TestViewModel для всех направлений")
    }
}

// MARK: - Usage Examples
/*
 
 // Пример использования в View:
 
 struct DirectionListView: View {
     @State private var testViewModel: TestViewModel?
     @State private var selectedDirection: DirectionType?
     
     var body: some View {
         List(DirectionType.allCases, id: \.self) { direction in
             Button(direction.displayName) {
                 selectedDirection = direction
                 testViewModel = TestViewModel(directionType: direction)
             }
         }
         .sheet(item: $selectedDirection) { direction in
             if let testViewModel = testViewModel {
                 TestView(viewModel: testViewModel)
             }
         }
     }
 }
 
 // Пример использования в ViewModel:
 
 @Observable final class DirectionListViewModel {
     private let networkService = NetworkService.shared
     var directions: [FitnessDirection] = FitnessDirection.directions
     
     func loadQuestionsForDirection(_ direction: FitnessDirection) async -> [Question]? {
         do {
             return try await networkService.fetchQuestions(for: direction)
         } catch {
             print("Ошибка загрузки вопросов: \(error)")
             return nil
         }
     }
 }
 
 */ 