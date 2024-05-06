//
//  SignInViewModel.swift
//  ThoughtTrace
//
//  Created by Bhavik Chotalia on 6/5/2024.
//

import Foundation

class SignInViewModel: ObservableObject {
    @Published var emailFieldViewModel: InputFieldViewModel
    @Published var passwordFieldViewModel: InputFieldViewModel

    init() {
        emailFieldViewModel = InputFieldViewModel(
            text: "", title: "Email", placeholder: "Enter Email", isSecureField: false
        )
        passwordFieldViewModel = InputFieldViewModel(
            text: "", title: "Password", placeholder: "Enter Password", isSecureField: true
        )
    }
}
