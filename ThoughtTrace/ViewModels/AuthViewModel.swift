//
//  AuthViewModel.swift
//  ThoughtTrace
//
//  Created by Bhavik Chotalia on 6/5/2024.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation
import SwiftUI

protocol AuthFormProtocol {
    var isFormValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: UserModel?
    @Published var isAuthenticated: Bool = false
    @Published var showToast: Bool = false
    @Published var authErrorMessage: String = ""

    private var handle: AuthStateDidChangeListenerHandle?

    init() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.userSession = user
            self?.isAuthenticated = (user != nil)

            Task {
                await self?.fetchUser()
            }
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

    func signUp(fullname: String, email: String, password: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            await saveUser(
                user: UserModel(id: result.user.uid, fullname: fullname, email: email, tasks: []))
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

    func saveUser(user: UserModel) async {
        try? Firestore.firestore().collection("users").document(user.id).setData(
            from: user, merge: true)
        await fetchUser()
    }

    private func fetchUser() async {
        if let userId = userSession?.uid {
            do {
                let user = try await Firestore.firestore().collection("users").document(userId).getDocument(
                    as: UserModel.self)
                currentUser = user
            } catch {
                print("Error fetching user from db", error)
                currentUser = nil
            }
        } else {
            currentUser = nil
        }
    }

    func changePassword(password: String, dismiss: DismissAction) async {
        do {
            try await userSession?.updatePassword(to: password)

            dismiss()
        } catch {
            if let error = error as NSError? {
                let code = AuthErrorCode.Code(rawValue: error.code)

                switch code {
                case .requiresRecentLogin:
                    authErrorMessage =
                        "This operation is sensitive and requires recent login. Please login again"
                case .weakPassword:
                    authErrorMessage = "Password is too weak. Please use different password"
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
