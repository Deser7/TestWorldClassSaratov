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
    let viewModel: ResultViewModel
    let onDismiss: () -> Void
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            // MARK: - Title
            Text("Тест завершен!")
                .font(.title)
                .fontWeight(.bold)
            
            // MARK: - Direction Name
            Text(viewModel.directionName)
                .font(.title3)
                .foregroundColor(.secondary)
            
            // MARK: - Score
            Text("\(Int(viewModel.percentage))%")
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(scoreColor)
            
            // MARK: - Grade
            Text(viewModel.grade)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(scoreColor)
            
            // MARK: - Detailed Results
            VStack(spacing: 10) {
                HStack {
                    Text("Правильных ответов:")
                    Spacer()
                    Text("\(viewModel.correctAnswers) из \(viewModel.totalQuestions)")
                        .fontWeight(.semibold)
                }
                
                HStack {
                    Text("Время выполнения:")
                    Spacer()
                    Text(viewModel.formattedTimeSpent)
                        .fontWeight(.semibold)
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            
            // MARK: - Result Message
            Text(viewModel.getResultMessage())
                .multilineTextAlignment(.center)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(viewModel.isPassed ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                )
            
            // MARK: - Dismiss Button
            Button("Вернуться к выбору направления") {
                onDismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
        }
        .padding()
    }
    
    // MARK: - Computed Properties
    private var scoreColor: Color {
        if viewModel.isPassed {
            switch viewModel.percentage {
            case 90...100: return .green
            case 80..<90: return .orange
            default: return .blue
            }
        } else {
            return .red
        }
    }
}

// MARK: - Preview
#Preview {
    ResultView(
        viewModel: ResultViewModel(
            score: 85,
            totalQuestions: 10,
            correctAnswers: 8,
            directionName: "Тренажерный зал",
            timeSpent: 1200
        ),
        onDismiss: {}
    )
}
