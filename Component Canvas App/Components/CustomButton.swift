//
//  CustomButton.swift
//  Component Canvas App
//
//  Created by Teenu  on 12/10/26.
//


import SwiftUI

public enum ButtonVariant {
    case primary
    case secondary
    case destructive
}

public struct CustomButton: View {
    public let title: String
    public var icon: String?
    public var variant: ButtonVariant
    public var isLoading: Bool
    public var isEnabled: Bool = true
    public let action: () -> Void

    public init(
        title: String,
        icon: String? = nil,
        variant: ButtonVariant = .primary,
        isLoading: Bool = false,
        isEnabled: Bool = true,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.icon = icon
        self.variant = variant
        self.isLoading = isLoading
        self.isEnabled = isEnabled
        self.action = action
    }

    private var backgroundColor: Color {
        guard isEnabled else { return Color(UIColor.systemGray5) }
        switch variant {
        case .primary: return .blue
        case .secondary: return Color(.systemGray)
        case .destructive: return .red
        }
    }

    private var foregroundColor: Color {
        switch variant {
        case .primary, .destructive: return .white
        case .secondary: return .primary
        }
    }

    public var body: some View {
        Button(action: {
                guard !isLoading else { return }
                action()
            }) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView().tint(foregroundColor)
                } else {
                    if let icon {
                        Image(systemName: icon)
                    }
                    Text(title).fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .disabled(isLoading)
    }
}
