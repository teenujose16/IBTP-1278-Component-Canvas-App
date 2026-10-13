//
//  CustomModal.swift
//  Component Canvas App
//
//  Created by Teenu  on 12/10/26.
//

import SwiftUI

public struct CustomModalModifier<ModalContent: View>: ViewModifier {
    @Binding public var isPresented: Bool
    public var title: String
    public let modalContent: () -> ModalContent

    public func body(content: Content) -> some View {
        content.sheet(isPresented: $isPresented) {
            NavigationStack {
                VStack(alignment: .leading, spacing: 16) {
                    modalContent()
                    Spacer()
                }
                .padding()
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") { isPresented = false }
                    }
                }
            }
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
    }
}

public extension View {
    func dsModal<ModalContent: View>(
        isPresented: Binding<Bool>,
        title: String,
        @ViewBuilder content: @escaping () -> ModalContent
    ) -> some View {
        modifier(CustomModalModifier(isPresented: isPresented, title: title, modalContent: content))
    }
}
