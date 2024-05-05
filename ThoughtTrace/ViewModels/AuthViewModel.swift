//
//  AuthViewModel.swift
//  ThoughtTrace
//
//  Created by Bhavik Chotalia on 6/5/2024.
//

import FirebaseAuth
import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var isAuthenticated: Bool = false

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
            print("SignIn failed: \(error.localizedDescription)")
        }
    }

    func signUp(email: String, password: String) async {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
        } catch {
            print("SignUp failed: \(error.localizedDescription)")
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("SignOut failed: \(error.localizedDescription)")
        }
    }
}
