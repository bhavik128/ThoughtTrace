//
//  SignUpViewModel.swift
//  ThoughtTrace
//
//  Created by Bhavik Chotalia on 6/5/2024.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var nameFieldViewModel: InputFieldViewModel
    @Published var emailFieldViewModel: InputFieldViewModel
    @Published var passwordFieldViewModel: InputFieldViewModel
    @Published var confirmPasswordViewModel: InputFieldViewModel

    init() {
        nameFieldViewModel = InputFieldViewModel(
            text: "", title: "Name", placeholder: "Enter Name", isSecureField: false
        )
        emailFieldViewModel = InputFieldViewModel(
            text: "", title: "Email", placeholder: "Enter Email", isSecureField: false
        )
        passwordFieldViewModel = InputFieldViewModel(
            text: "", title: "Password", placeholder: "Enter Password", isSecureField: true
        )
        confirmPasswordViewModel = InputFieldViewModel(
            text: "", title: "Confirm Password", placeholder: "Confirm Password", isSecureField: true
        )
    }
}
