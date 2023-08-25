//
//  ContentView.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 24/8/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel()

    var body: some View {
        NavigationView {
            if authViewModel.isSignedIn {
                if !authViewModel.hasBabyInfo {
                    BabyInfoView()
                } else {
                    HomeView()
                }
            } else {
                LoginView()
                    .environmentObject(authViewModel)
            }}.environmentObject(authViewModel).onAppear() {
                print("ContentView appeared. isSignedIn: \(authViewModel.isSignedIn), hasBabyInfo: \(authViewModel.hasBabyInfo)")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
