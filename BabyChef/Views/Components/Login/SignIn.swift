//
//  SignIn.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 25/8/23.
//

import SwiftUI

struct SignIn: View {
    @ObservedObject var authViewModel = AuthViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false

    var body: some View {
        Form {
            Section {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
            }

            Button("Connexion") {
                authViewModel.signIn(email: email, password: password) { success, error in
                    showError = !success
                }
            }
            
            if showError {
                Text("Erreur lors de la connexion. Veuillez réessayer.")
                    .foregroundColor(.red)
            }
        }
    }
}

