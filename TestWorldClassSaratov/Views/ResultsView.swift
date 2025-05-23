//
//  ResultsView.swift
//  TestWorldClassSaratov
//
//  Created by Наташа Спиридонова on 16.05.2025.
//

import SwiftUI

// MARK: - ResultsView
struct ResultsView: View {
    // MARK: - Properties
    let score: Int
    let totalQuestions: Int
    let onRestart: () -> Void
    
    // MARK: - Computed Properties
    private var successPercentage: Int {
        guard totalQuestions > 0 else { return 0 }
        return Int((Double(score) / Double(totalQuestions)) * 100)
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            // MARK: - Title
            Text("Результаты теста")
                .font(.title)
                .fontWeight(.bold)
            
            // MARK: - Results Card
            VStack(spacing: 10) {
                Text("Правильных ответов: \(score) из \(totalQuestions)")
                    .font(.title2)
                
                Text("Процент успешности: \(successPercentage)%")
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.systemBackground))
                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
            )
            
            // MARK: - Restart Button
            Button("Начать заново") {
                onRestart()
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .padding()
        }
        .padding()
    }
}

// MARK: - Preview
#Preview {
    ResultsView(score: 10, totalQuestions: 10, onRestart: {})
}
