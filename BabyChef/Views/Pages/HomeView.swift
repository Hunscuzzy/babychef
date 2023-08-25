//
//  HomeView.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 25/8/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        Text("Bienvenue à la maison!")
        Button("Déconnexion") {
            authViewModel.signOut()
        }
        Text("test")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
