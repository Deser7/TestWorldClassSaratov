//
//  DirectionCard.swift
//  TestWorldClassSaratov
//
//  Created by Наташа Спиридонова on 16.05.2025.
//

import SwiftUI

// MARK: - DirectionCardView
struct DirectionCardView: View {
    // MARK: - Properties
    let direction: FitnessDirection
    let isSelected: Bool
    let onTap: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 15) {
                // MARK: - Icon
                Image(systemName: direction.icon)
                    .font(.title)
                    .foregroundColor(isSelected ? .white : .green)
                    .frame(width: 50, height: 50)
                    .background(
                        Circle()
                            .fill(isSelected ? Color.green : Color.green.opacity(0.1))
                    )
                
                // MARK: - Text Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(direction.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(direction.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                // MARK: - Selection Indicator
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.title2)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.secondarySystemBackground))
                    .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isSelected ? Color.green : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
    }
}

// MARK: - Preview
#Preview {
    DirectionCardView(direction: FitnessDirection.directions[0], isSelected: false, onTap: {})
}
