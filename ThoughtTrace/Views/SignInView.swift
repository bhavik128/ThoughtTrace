//
//  SignInView.swift
//  ThoughtTrace
//
//  Created by Bhavik Chotalia on 6/5/2024.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    @StateObject var emailFieldViewModel = InputFieldViewModel(
        text: "", title: "Email", placeholder: "Enter Email", isSecureField: false
    )
    @StateObject var passwordFieldViewModel = InputFieldViewModel(
        text: "", title: "Password", placeholder: "Enter Password", isSecureField: true
    )

    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 20) {
                    InputFieldView(
                        viewModel: emailFieldViewModel
                    ).textInputAutocapitalization(.never).autocorrectionDisabled(true).keyboardType(
                        .emailAddress)

                    InputFieldView(
                        viewModel: passwordFieldViewModel
                    ).textInputAutocapitalization(.never).autocorrectionDisabled(true)
                }.padding(.horizontal)

                Button {
                    Task {
                        await authViewModel.signIn(
                            email: emailFieldViewModel.text,
                            password: passwordFieldViewModel.text
                        )
                    }
                } label: {
                    HStack {
                        Text("Sign In").bold()
                        Image(systemName: "arrow.right")
                    }.foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(.blue)
                .cornerRadius(10)
                .padding(.top, 20)
                .disabled(!isFormValid)
                .opacity(isFormValid ? 1.0 : 0.5)

                Spacer()

                NavigationLink {
                    SignUpView().navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Text("Don't have an account?")
                        Text("Sign Up").bold()
                    }
                }
            }
        }
    }
}

extension SignInView: AuthFormProtocol {
    var isFormValid: Bool {
        return !emailFieldViewModel.text.isEmpty && emailFieldViewModel.text.contains("@")
            && passwordFieldViewModel.text.count > 5 && !passwordFieldViewModel.text.isEmpty
    }
}

#Preview {
    SignInView().environmentObject(AuthViewModel())
}