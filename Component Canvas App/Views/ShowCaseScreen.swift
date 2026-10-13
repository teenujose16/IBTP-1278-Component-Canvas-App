//
//  ShowCaseScreen.swift
//  Component Canvas App
//
//  Created by Teenu  on 13/10/26.
//



import SwiftUI

struct UserAccountManagerView: View {
    // MARK: - Input State
    @State private var email: String = ""
    @State private var password: String = ""
    
    // MARK: - App & UI State
    @State private var savedEmail: String = "No account linked"
    @State private var isLoading: Bool = false
    @State private var showSheet: Bool = false
    @State private var showDeleteAlert: Bool = false
    
    // MARK: - Validation Rules
    private var isEmailValid: Bool {
        if email.isEmpty { return true }
        return email.contains("@") && email.contains(".")
    }
    
    private var isPasswordValid: Bool {
        if password.isEmpty { return true }
        return password.count >= 6
    }
    
    private var canSubmit: Bool {
        !email.isEmpty && !password.isEmpty && isEmailValid && isPasswordValid && !isLoading
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: - 1. Inputs Section
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Account Credentials")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        // Email Field
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Email")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            TextField("Enter email address", text: $email)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .padding(12)
                                .background(Color(.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(!isEmailValid ? Color.red : Color.clear, lineWidth: 1.5)
                                )
                            
                            if !isEmailValid {
                                Text("Please enter a valid email address.")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        // Password Field
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Password")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            SecureField("Enter password (min 6 chars)", text: $password)
                                .padding(12)
                                .background(Color(.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(!isPasswordValid ? Color.red : Color.clear, lineWidth: 1.5)
                                )
                            
                            if !isPasswordValid {
                                Text("Password must be at least 6 characters.")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    
                    // MARK: - 2. Dynamic Cards Section
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Profile Overview")
                            .font(.headline)
                        
                        // Elevated Card (Active User Info)
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "person.crop.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                Text("Active User")
                                    .font(.subheadline.bold())
                                Spacer()
                                Text(savedEmail == "No account linked" ? "Unlinked" : "Active")
                                    .font(.caption.bold())
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(savedEmail == "No account linked" ? Color.gray.opacity(0.2) : Color.green.opacity(0.2))
                                    .foregroundColor(savedEmail == "No account linked" ? .secondary : .green)
                                    .clipShape(Capsule())
                            }
                            
                            Text(savedEmail)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        .padding(16)
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
                        
                        // Outlined Card (Security & Password State)
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Image(systemName: "shield.checkered")
                                    .foregroundColor(.orange)
                                Text("Security Status")
                                    .font(.subheadline.bold())
                            }
                            
                            Text(password.isEmpty ? "No active password entered." : "Password strength: \(password.count >= 8 ? "Strong" : "Moderate")")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemBackground).opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.secondary.opacity(0.25), lineWidth: 1)
                        )
                    }
                    
                    // MARK: - 3. Buttons Section
                    VStack(spacing: 12) {
                        // Save Changes
                        CustomButton(
                            title: "Save Changes",
                            icon: "checkmark",
                            variant: .primary,
                            isLoading: isLoading
                        ) {
                            handleSave()
                        }
                        
                        // Open Sheet
                        CustomButton(
                            title: "Open Sheet",
                            icon: "slider.horizontal.3",
                            variant: .secondary,
                    
                        ) {
                            showSheet = true
                        }
                        
                        // Delete
                        CustomButton(
                            title: "Delete Account Data",
                            icon: "trash",
                            variant: .destructive,
                            isEnabled: !email.isEmpty || savedEmail != "No account linked"
                        ) {
                            showDeleteAlert = true
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Account Manager")
            .sheet(isPresented: $showSheet) {
                NavigationStack {
                    VStack(spacing: 16) {
                        Image(systemName: "person.text.rectangle")
                            .font(.system(size: 48))
                            .foregroundColor(.blue)
                        Text("Extended Settings")
                            .font(.title2.bold())
                        Text("Manage 2FA, session tokens, and recovery phrases.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Done") { showSheet = false }
                        }
                    }
                }
            }
            .alert("Confirm Deletion", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    resetAllData()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure you want to clear your credentials and reset account data?")
            }
        }
    }
    
    // MARK: - Logic Handlers
    private func handleSave() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            savedEmail = email
            isLoading = false
        }
    }
    
    private func resetAllData() {
        email = ""
        password = ""
        savedEmail = "No account linked"
    }
}
