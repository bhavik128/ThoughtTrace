//
//  SignUpView.swift
//  ThoughtTrace
//
//  Created by Bhavik Chotalia on 6/5/2024.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var toastViewModel: ToastViewModel
    @Environment(\.dismiss) var dismiss

    @StateObject var nameFieldViewModel = InputFieldViewModel(
        text: "", title: "Name", placeholder: "Enter Name", isSecureField: false
    )
    @StateObject var emailFieldViewModel = InputFieldViewModel(
        text: "", title: "Email", placeholder: "Enter Email", isSecureField: false
    )
    @StateObject var passwordFieldViewModel = InputFieldViewModel(
        text: "", title: "Password", placeholder: "Enter Password", isSecureField: true
    )
    @StateObject var confirmPasswordFieldViewModel = InputFieldViewModel(
        text: "", title: "Confirm Password", placeholder: "Confirm Password", isSecureField: true
    )

    var body: some View {
        VStack {
            VStack(spacing: 20) {
                InputFieldView(
                    viewModel: nameFieldViewModel
                )

                InputFieldView(
                    viewModel: emailFieldViewModel
                ).textInputAutocapitalization(.never).autocorrectionDisabled(true).keyboardType(
                    .emailAddress)

                InputFieldView(
                    viewModel: passwordFieldViewModel
                ).textInputAutocapitalization(.never).autocorrectionDisabled(true)

                InputFieldView(
                    viewModel: confirmPasswordFieldViewModel
                ).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }.padding(.horizontal)

            Button {
                Task {
                    await authViewModel.signUp(
                        fullname: nameFieldViewModel.text,
                        email: emailFieldViewModel.text,
                        password: passwordFieldViewModel.text
                    )
                }
            } label: {
                HStack {
                    Text("Sign Up").bold()
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(.blue)
            .cornerRadius(10)
            .padding(.top, 20)
            .disabled(!isFormValid)
            .opacity(isFormValid ? 1.0 : 0.5)

            Spacer()

            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                    Text("Sign In").bold()
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

extension SignUpView: AuthFormProtocol {
    var isFormValid: Bool {
        return !emailFieldViewModel.text.isEmpty && emailFieldViewModel.text.contains("@")
            && passwordFieldViewModel.text.count > 5 && confirmPasswordFieldViewModel.text.count > 5
            && passwordFieldViewModel.text == confirmPasswordFieldViewModel.text
            && !nameFieldViewModel.text.isEmpty && !passwordFieldViewModel.text.isEmpty
            && !confirmPasswordFieldViewModel.text.isEmpty
    }
}

#Preview {
    SignUpView().environmentObject(AuthViewModel()).environmentObject(ToastViewModel())
}
