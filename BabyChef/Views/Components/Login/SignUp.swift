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
    @State private var firstName: String = ""
    @State private var gender: String = ""
    @State private var birthDate: Date = Date()
    @State private var showError: Bool = false
    @State private var currentStep: Int = 1
    @State private var specificErrorMessage: String = ""
    
    var body: some View {
        if authViewModel.isLoading {
            ProgressView()
        }

        if !specificErrorMessage.isEmpty {
            Text(specificErrorMessage)
                .foregroundColor(.red)
        }
        
        VStack {
            Text("Bienvenue !")
            Spacer()
            
            if currentStep == 1 {
                SignUpStepOne(firstName: $firstName, gender: $gender, birthDate: $birthDate, currentStep: $currentStep)
            } else if currentStep == 2 {
                SignUpStepTwo(email: $email, password: $password, confirmPassword: $confirmPassword, showError: $showError)
                Button("Créer mon compte") {
                    guard email != "", password != "", firstName != "", gender != "" else {
                        specificErrorMessage = "Tous les champs doivent être remplis."
                        return
                    }

                    guard password == confirmPassword else {
                        specificErrorMessage = "Les mots de passe ne correspondent pas."
                        return
                    }

                    authViewModel.completeSignUp(email: email, password: password, firstName: firstName, gender: gender, birthDate: birthDate) { success, error in
                        if !success {
                            specificErrorMessage = authViewModel.errorMessage ?? "Une erreur s'est produite."
                        }
                    }
                }.disabled(authViewModel.isLoading)
            }
        }
    }
}
