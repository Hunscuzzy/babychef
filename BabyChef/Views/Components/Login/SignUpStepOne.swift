//
//  SignUpStepOne.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 27/8/23.
//

import SwiftUI

struct SignUpStepOne: View {
    @Binding var firstName: String
    @Binding var gender: String
    @Binding var birthDate: Date
    @Binding var currentStep: Int

    let genders = ["Maman", "Papa"]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Infos sur le chef")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)

            BcTextField(label: "Prénom", text: $firstName)

            BcToggleButton(label: "Sexe", value: $gender, values: genders)

            BcDatePicker(label: "Date de naissance", date: $birthDate)
            
            Button("Continuer") {
                currentStep += 1
            }
            .foregroundColor(.white)
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(8)

        }
        .padding(20)
    }
}
