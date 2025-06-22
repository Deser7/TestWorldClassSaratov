//
//  TestResultView.swift
//  TestWorldClassSaratov
//
//  Created by Наташа Спиридонова on 16.05.2025.
//

import SwiftUI

// MARK: - TestResultView
struct ResultView: View {
    // MARK: - Properties
    let score: Int
    let onDismiss: () -> Void
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            // MARK: - Title
            Text("Тест завершен!")
                .font(.title)
                .fontWeight(.bold)
            
            // MARK: - Result Label
            Text("Ваш результат:")
                .font(.title2)
            
            // MARK: - Score
            Text("\(score)%")
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(scoreColor)
            
            // MARK: - Result Message
            Text(resultMessage)
                .multilineTextAlignment(.center)
                .padding()
            
            // MARK: - Dismiss Button
            Button("Вернуться к выбору направления") {
                onDismiss()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
    
    // MARK: - Computed Properties
    private var scoreColor: Color {
        switch score {
        case 0..<80:
            return .red
        case 80..<90:
            return .yellow
        default:
            return .green
        }
    }
    
    private var resultMessage: String {
        switch score {
        case 0..<80:
            return "Вам нужно больше практики. Рекомендуем повторить материал и попробовать снова."
        case 80..<90:
            return "Хороший результат! Есть куда расти, но база знаний уже есть."
        default:
            return "Отличный результат! Вы хорошо знаете материал."
        }
    }
}

// MARK: - Preview
#Preview {
    ResultView(score: 100, onDismiss: {})
}
