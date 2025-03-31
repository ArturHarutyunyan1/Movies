//
//  AuthenticationManager.swift
//  Movies
//
//  Created by Artur Harutyunyan on 30.03.25.
//

import SwiftUI
import Firebase
import FirebaseAuth

class AuthenticationManager : ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated: Bool = false
    @Published var isEmailVerified: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    private var authStateListener: AuthStateDidChangeListenerHandle?
    
    init() {
        authStateListener = Auth.auth().addStateDidChangeListener {[weak self] _, user in
            DispatchQueue.main.async {
                guard let self = self else {return}
                
                self.user = user
                self.isAuthenticated = user != nil
                self.reloadState()
            }
        }
    }
    
    func signUp(email: String, password: String) {
        self.isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) {result, error in
            if let error = error {
                self.setErrorMessage(error: error.localizedDescription)
                self.isLoading = false
                return
            }
            if let user = result?.user {
                self.user = user
                self.isAuthenticated = true
                self.isEmailVerified = user.isEmailVerified
                self.sendVerificationEmail(to: email)
                self.reloadState()
                self.isLoading = false
            }
        }
    }
    
    func signIn(email: String, password: String) {
        self.isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) {result, error in
            if let error = error {
                self.setErrorMessage(error: error.localizedDescription)
                self.isLoading = false
                return
            }
            if let user = result?.user {
                self.user = user
                self.isAuthenticated = true
                self.isEmailVerified = user.isEmailVerified
                self.reloadState()
                self.isLoading = false
            }
        }
    }
    
    func reloadState() {
        guard let user = self.user else {return}
        self.isLoading = true
        user.reload {error in
            if let error = error {
                self.setErrorMessage(error: error.localizedDescription)
                self.isLoading = false
                return
            }
            self.isEmailVerified = user.isEmailVerified
            self.isLoading = false
        }
    }
    
    func sendVerificationEmail(to email: String) {
        guard let user = self.user else {return}
        self.isLoading = true
        user.sendEmailVerification {error in
            if let error = error {
                self.setErrorMessage(error: error.localizedDescription)
                self.isLoading = false
                return
            }
            self.isLoading = false
        }
    }
    
    func checkVerificationStatus() {
        guard let user = self.user else {return}
        self.isLoading = true
        user.reload {error in
            if let error = error {
                self.setErrorMessage(error: error.localizedDescription)
                self.isLoading = false
                return
            }
            DispatchQueue.main.async {
                self.isEmailVerified = user.isEmailVerified
                self.isLoading = false
            }
        }
    }
    
    func signOut() {
        self.isLoading = true
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isAuthenticated = false
            self.isEmailVerified = false
            self.isLoading = false
        } catch {
            self.setErrorMessage(error: error.localizedDescription)
            self.isLoading = false
        }
    }
    
    private func setErrorMessage(error: String) {
        self.isLoading = true
        DispatchQueue.main.async {
            self.errorMessage = error
            self.isLoading = false
        }
    }
    
    deinit {
        if let authStateListener = authStateListener {
            Auth.auth().removeStateDidChangeListener(authStateListener)
        }
    }
}
