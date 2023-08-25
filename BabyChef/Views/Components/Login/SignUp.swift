//
//  SignUpView.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 25/8/23.
//

import SwiftUI

struct SignUp: View {
    @ObservedObject var authViewModel = AuthViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showError: Bool = false

    var body: some View {
        Form {
            Section {
                TextField("Email", text: $email)
                SecureField("Mot de passe", text: $password)
                SecureField("Confirmer le mot de passe", text: $confirmPassword)
            }

            Button("S'inscrire") {
                if password == confirmPassword {
                    authViewModel.signUp(email: email, password: password) { success, error in
                        showError = !success
                    }
                } else {
                    showError = true
                }
            }
            
            if showError {
                Text("Erreur lors de l'inscription. Veuillez réessayer.")
                    .foregroundColor(.red)
            }
        }
    }
}
