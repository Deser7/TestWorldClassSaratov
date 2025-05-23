//
//  QuestionView.swift
//  TestWorldClassSaratov
//
//  Created by Наташа Спиридонова on 16.05.2025.
//

import SwiftUI

// MARK: - QuestionView
struct QuestionView: View {
    // MARK: - Properties
    let question: Question
    let selectedAnswerIndex: Int?
    let onAnswerSelected: (Int) -> Void
    let onNext: () -> Void
    let onPrevious: () -> Void
    let isLastQuestion: Bool
    let isFirstQuestion: Bool
    let progress: Double
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            // MARK: - Progress Bar
            ProgressView(value: progress)
                .tint(.green)
                .padding(.horizontal)
            
            // MARK: - Question Text
            Text(question.text)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundStyle(.primary)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBackground))
                        .shadow(radius: 2)
                )
            
            // MARK: - Answer Buttons
            ForEach(question.answers.indices, id: \.self) { index in
                AnswerButtonView(
                    text: question.answers[index],
                    isSelected: selectedAnswerIndex == index,
                    action: {
                        onAnswerSelected(index)
                    }
                )
            }
            
            Spacer()
            
            // MARK: - Navigation Buttons
            HStack {
                if !isFirstQuestion {
                    Button(action: onPrevious) {
                        Label("Назад", systemImage: "chevron.left")
                            .fontWeight(.semibold)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .disabled(selectedAnswerIndex == nil)
                }
                
                Spacer()
                
                Button(action: onNext) {
                    Label(isLastQuestion ? "Завершить" : "Далее", systemImage: "chevron.right")
                        .fontWeight(.semibold)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .disabled(selectedAnswerIndex == nil)
            }
            .padding()
        }
        .padding()
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Preview
#Preview {
    QuestionView(
        question: Question(
            id: 1,
            text: "Какой из следующих элементов является основным макронутриентом?",
            answers: [
                "Витамин C",
                "Белок",
                "Кальций",
                "Железо"
            ],
            correctAnswerIndex: 1
        ),
        selectedAnswerIndex: nil,
        onAnswerSelected: { _ in },
        onNext: {},
        onPrevious: {},
        isLastQuestion: false,
        isFirstQuestion: true,
        progress: 0.3
    )
}
