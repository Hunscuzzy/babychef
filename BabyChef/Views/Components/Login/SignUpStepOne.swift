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
        VStack {
            Text("Infos sur le chef")
            Form {
                Section {
                    TextField("Prénom", text: $firstName)
                    Picker("Sexe", selection: $gender) {
                        ForEach(genders, id: \.self) { gender in
                            Text(gender).tag(gender)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    DatePicker("Date de naissance", selection: $birthDate, displayedComponents: .date)
                }
                
                Button("Continuer") {
                    currentStep = 2
                }
            }
        }
    }
}
