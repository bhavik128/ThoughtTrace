//
//  AuthViewModel.swift
//  ThoughtTrace
//
//  Created by Bhavik Chotalia on 6/5/2024.
//

import FirebaseAuth
import Foundation

protocol AuthFormProtocol {
    var isFormValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var isAuthenticated: Bool = false
    @Published var showToast: Bool = false
    @Published var authErrorMessage: String = ""

    private var handle: AuthStateDidChangeListenerHandle?

    init() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.userSession = user
            self?.isAuthenticated = (user != nil)
        }
    }

    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    func signIn(email: String, password: String) async {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            if let error = error as NSError? {
                let code = AuthErrorCode.Code(rawValue: error.code)

                switch code {
                case .invalidEmail:
                    authErrorMessage = "Email invalid, Please try again"
                case .invalidCredential:
                    authErrorMessage = "Email or password incorrect, Please try again"
                default:
                    authErrorMessage = "Something went wrong, Please try again"
                }

                showToast = true
            }
        }
    }

    func signUp(email: String, password: String) async {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
        } catch {
            if let error = error as NSError? {
                let code = AuthErrorCode.Code(rawValue: error.code)

                switch code {
                case .invalidEmail:
                    authErrorMessage = "Email invalid, Please try again"
                case .emailAlreadyInUse:
                    authErrorMessage = "Email already in use"
                default:
                    authErrorMessage = "Something went wrong, Please try again"
                }

                showToast = true
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("SignOut failed: \(error.localizedDescription)")
        }
    }

    func resetError() {
        showToast = false
        authErrorMessage = ""
    }
}
