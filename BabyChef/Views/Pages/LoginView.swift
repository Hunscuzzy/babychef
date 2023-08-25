//
//  LoginView.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 25/8/23.
//

import SwiftUI

struct LoginView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            SignIn()
                .tabItem {
                    Text("Se connecter")
                }
                .tag(0)

            SignUp()
                .tabItem {
                    Text("S'inscrire")
                }
                .tag(1)
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
