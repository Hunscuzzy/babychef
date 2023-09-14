//
//  SignUpStepTwo.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 27/8/23.
//

import SwiftUI

struct SignUpStepTwo: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var showError: Bool
    @Binding var currentStep: Int
    
    var body: some View {
        VStack {
            Form {
                Text("Infos sur le compte").font(.title).frame(maxWidth: .infinity, alignment: .center)
                BcTextField(label: "Email", text: $email)
                BcSecureField(label: "Mot de passe", text: $password)
                BcSecureField(label: "Confirmer le mot de passe", text: $confirmPassword)
                
                if showError {
                    Text("Erreur lors de l'inscription. Veuillez réessayer.")
                        .foregroundColor(.red)
                }
                
                Button("Précédent") {
                    currentStep -= 1
                }
            }
        }
    }
}
