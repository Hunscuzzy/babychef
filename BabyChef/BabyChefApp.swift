//
//  BabyChefApp.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 24/8/23.
//

import SwiftUI
import FirebaseCore

@main
struct BabyChefApp: App {
    init() {
        FirebaseApp.configure()
    }

    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
