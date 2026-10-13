



## Demo Walkthorugh


Watch the walkthrough of all components and screen interactions:

- **Video Link:**  [https://www.loom.com/share/b37a96e0a9324420a25e40a8ed1eb963]



## Component Canvas UI Kit 



A lightweight, reusable SwiftUI design system library.

1. CustomButton


A multipurpose button supporting multiple color variants, loading states, icons, and disabled states.

Swift
CustomButton(
    title: "Save Changes",
    icon: "checkmark",
    variant: .primary,
    isLoading: false,
    isEnabled: true,
    action: { /* tap action */ }
)
Parameter    Type    Default    Description
title    String    (Required)    Text displayed on the button.
icon    String?    nil    Optional SF Symbol name placed before the text.
variant    ButtonVariant    .primary    Style theme: .primary (blue), .secondary (gray), .destructive (red).
isLoading    Bool    false    When true, hides content and displays a ProgressView spinner; disables tap.
isEnabled    Bool    true    When false, changes background to light gray system color.
action    () -> Void    {}    Closure executed when tapped.



2. CustomCard<Content>


A container component for grouping views into elevated or outlined card styles.

Swift
CustomCard(style: .elevated) {
    Text("Card Content")
}
Parameter    Type    Default    Description
style    CardStyle    .elevated    .elevated (drop shadow) or .outlined (subtle border stroke).
content    @ViewBuilder () -> Content    (Required)    View builder closure containing child elements.


3. CustomFormInput


A labeled input component with built-in support for secure password fields and red error validation states.

Swift
CustomFormInput(
    label: "Email",
    placeholder: "Enter email address",
    text: $email,
    isSecure: false,
    error: isEmailValid ? nil : "Invalid email"
)
Parameter    Type    Default    Description
label    String    (Required)    Header caption text displayed above the input.
placeholder    String    (Required)    Hint text displayed when field is empty.
text    Binding<String>    (Required)    Two-way binding for the entered string value.
isSecure    Bool    false    Renders a SecureField when true, otherwise TextField.
error    String?    nil    Optional error message. If present, renders a red border and error caption.


4. dsModal (CustomModalModifier)


A view modifier and extension for presenting a standardized bottom sheet with a navigation bar and "Done" button.

Swift
myView.dsModal(isPresented: $showSheet, title: "Settings") {
    Text("Modal Body")
}
Parameter    Type    Default    Description
isPresented    Binding<Bool>    (Required)    Binding controlling the presentation state of the sheet.
title    String    (Required)    Title shown in the sheet’s navigation bar.
content    @ViewBuilder () -> ModalContent    (Required)    Views rendered inside the sheet.


5. UserAccountManagerView


An example screen integrating all components above into a complete credentials and profile management flow:

Inputs Section: Reactive email & password inputs with live validation.

Cards Section: Displays active account status (CustomCard) and password strength.

Actions Section: Connects CustomButton instances for primary save (isLoading), opening the settings modal (dsModal), and destructive account deletion (showDeleteAlert).
