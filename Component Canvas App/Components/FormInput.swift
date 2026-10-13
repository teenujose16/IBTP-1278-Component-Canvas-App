//
//  FormInput.swift
//  Component Canvas App
//
//  Created by Teenu  on 12/10/26.
//
import SwiftUI

public struct CustomFormInput: View {
    public let label: String
    public let placeholder: String
    @Binding public var text: String
    public var isSecure: Bool
    public var error: String?

    public init(
        label: String,
        placeholder: String,
        text: Binding<String>,
        isSecure: Bool = false,
        error: String? = nil
    ) {
        self.label = label
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
        self.error = error
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)

            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(error != nil ? Color.red : Color.clear, lineWidth: 1)
            )

            if let error {
                Text(error)
                    .font(.caption2)
                    .foregroundColor(.red)
            }
        }
    }
}
