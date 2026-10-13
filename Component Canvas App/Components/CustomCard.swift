//
//  CustomCard.swift
//  Component Canvas App
//
//  Created by Teenu  on 12/10/26.
//

import SwiftUI

public enum CardStyle {
    case elevated
    case outlined
}

public struct CustomCard<Content: View>: View {
    public var style: CardStyle
    public let content: () -> Content

    public init(style: CardStyle = .elevated, @ViewBuilder content: @escaping () -> Content) {
        self.style = style
        self.content = content
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            content()
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(style == .outlined ? Color.secondary.opacity(0.2) : .clear, lineWidth: 1)
        )
        .shadow(
            color: style == .elevated ? Color.black.opacity(0.06) : .clear,
            radius: 8,
            x: 0,
            y: 4
        )
    }
}
