//
//  BabyInfoView.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 25/8/23.
//

import SwiftUI

struct BabyInfoView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    @State private var firstName: String = ""
    @State private var birthDate: Date = Date()
    @State private var gender: String = "Garçon"

    var body: some View {
        Form {
            Section(header: Text("Informations sur le bébé")) {
                TextField("Prénom", text: $firstName)
                DatePicker("Date de naissance", selection: $birthDate, displayedComponents: .date)
                Picker("Sexe", selection: $gender) {
                    Text("Garçon").tag("Garçon")
                    Text("Fille").tag("Fille")
                }
            }

            Button("Soumettre") {
                authViewModel.updateBabyInfo(firstName: firstName, birthDate: birthDate, gender: gender) { success, error in
                    if success {
                        print("Informations mises à jour avec succès.")
                    } else if let error = error {
                        print("Une erreur s'est produite: \(error)")
                    }
                }
            }
        }
    }
}

struct BabyInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BabyInfoView()
    }
}
