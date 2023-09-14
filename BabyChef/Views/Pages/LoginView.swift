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
        VStack {
                   Image("logo")
                       .resizable()
                       .scaledToFit()
                       .frame(width: 100, height: 100)
                   
                   Text("Baby Chef")
                       .font(.largeTitle)
                       .bold()
                       .padding(.bottom, 50)
            
                    Text("Des repas faits avec amour, pour ceux que vous aimez")
                        .font(.title2)
                        .padding(.bottom, 50)

                   NavigationLink(destination: SignUp()) {
                       Text("Devenir Chef")
                           .font(.headline)
                           .foregroundColor(.white)
                           .padding()
                           .frame(width: 220, height: 60)
                           .background(Color.blue)
                           .cornerRadius(15.0)
                   }

                   // Un lien vers la page de connexion
                   NavigationLink(destination: SignIn()) {
                       HStack {
                           Text("Je suis déjà Chef")
                               .font(.subheadline)
                           
                           Image(systemName: "arrow.right")
                               .imageScale(.medium)
                       }
                       .foregroundColor(.blue)
                       .padding(.top, 20)
                   }
               }
               .padding()
               .navigationBarHidden(true)
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
