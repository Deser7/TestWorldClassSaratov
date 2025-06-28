//
//  AnswerButton.swift
//  TestWorldClassSaratov
//
//  Created by Наташа Спиридонова on 16.05.2025.
//

import SwiftUI

// MARK: - AnswerButtonView
struct AnswerButtonView: View {
    // MARK: - Properties
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.body)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isSelected ? Color.green : Color(.systemBackground))
                )
                .foregroundStyle(isSelected ? .white : .primary)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.green, lineWidth: isSelected ? 0 : 1)
                )
                .shadow(radius: 1)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview
#Preview {
    AnswerButtonView(text: "Белок", isSelected: false, action: {})
}
