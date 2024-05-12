//
//  ChangePasswordView.swift
//  ThoughtTrace
//
//  Created by Bhavik Chotalia on 12/5/2024.
//

import SwiftUI
import SimpleToast

struct ChangePasswordView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var toastViewModel: ToastViewModel
    @StateObject private var newPasswordViewModel = InputFieldViewModel(
        text: "",
        title: "New Password",
        placeholder: "Enter new password",
        isSecureField: true
    )
    @StateObject private var confirmPasswordViewModel = InputFieldViewModel(
        text: "",
        title: "Confirm Password",
        placeholder: "Confirm new password",
        isSecureField: true
    )
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                InputFieldView(viewModel: newPasswordViewModel)
                InputFieldView(viewModel: confirmPasswordViewModel)

                Button {
                    Task {
                        await authViewModel.changePassword(password: newPasswordViewModel.text, dismiss: dismiss)
                    }
                } label: {
                    Text("Update Password")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.indigo)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .opacity(isFormValid ? 1.0 : 0.5)
                }
                .padding(.top, 20)
                .disabled(!isFormValid)

                Spacer()
            }
            .padding()
            .navigationTitle("Change Password")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                    }
                }
            }
        }
        .simpleToast(
            isPresented: $authViewModel.showToast, options: toastViewModel.toastOptions,
            onDismiss: { authViewModel.resetError() }
        ) {
            Label(authViewModel.authErrorMessage, systemImage: "exclamationmark.triangle")
                .padding()
                .background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding(.top)
        }
    }
}

extension ChangePasswordView: AuthFormProtocol {
    var isFormValid: Bool {
        return !newPasswordViewModel.text.isEmpty && !confirmPasswordViewModel.text.isEmpty
            && newPasswordViewModel.text == confirmPasswordViewModel.text
            && confirmPasswordViewModel.text.count > 5 && newPasswordViewModel.text.count > 5
    }
}

#Preview {
    ChangePasswordView().environmentObject(AuthViewModel()).environmentObject(ToastViewModel())
}
