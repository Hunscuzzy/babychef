//
//  Auth.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 25/8/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isSignedIn = false
    @Published var errorMessage: String?
    @Published var hasBabyInfo: Bool = false
    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
               guard let self = self else { return }
               
               if let user = user {
                   // L'utilisateur est connecté, vérifions s'il existe dans Firestore
                   let db = Firestore.firestore()
                   db.collection("users").document(user.uid).getDocument { (document, error) in
                       if let document = document, document.exists {
                           // L'utilisateur existe dans Firestore, mettons à jour l'état
                           self.user = user
                           self.isSignedIn = true
                           self.checkForBabyInfo()
                       } else {
                           // L'utilisateur n'existe pas dans Firestore, déconnexion
                           do {
                               try Auth.auth().signOut()
                               self.user = nil
                               self.isSignedIn = false
                           } catch let signOutError as NSError {
                               print("Error signing out: %@", signOutError)
                               self.errorMessage = signOutError.localizedDescription
                           }
                       }
                   }
               } else {
                   // L'utilisateur n'est pas connecté
                   self.user = nil
                   self.isSignedIn = false
               }
           }
    }

    deinit {
        // Suppression de l'écouteur lorsque le ViewModel est détruit
        if let handle = authStateDidChangeListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.handleAuthResult(result: result, error: error, completion: completion)
        }
    }

    func signUp(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            self.handleAuthResult(result: result, error: error, completion: completion)
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isSignedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            self.errorMessage = signOutError.localizedDescription
        }
    }
    
    func updateBabyInfo(firstName: String, birthDate: Date, gender: String, completion: @escaping (Bool, Error?) -> Void) {
        guard let user = user else { return }

        let db = Firestore.firestore()
        let babyInfo: [String: Any] = [
            "firstName": firstName,
            "birthDate": birthDate,
            "gender": gender
        ]

        db.collection("users").document(user.uid).setData(["babyInfo": babyInfo]) { error in
            if let error = error {
                completion(false, error)
                return
            }
            
            // Mettre à jour la valeur de hasBabyInfo
            self.hasBabyInfo = true

            completion(true, nil)
        }
    }
    
    func checkForBabyInfo() {
        guard let user = Auth.auth().currentUser else {
                return
            }

            let db = Firestore.firestore()
            db.collection("users").document(user.uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    self.hasBabyInfo = (data?["babyInfo"] as? [String: Any]) != nil
                } else {
                    self.hasBabyInfo = false
                }
            }
    }

    private func handleAuthResult(result: AuthDataResult?, error: Error?, completion: @escaping (Bool, Error?) -> Void) {
        if let error = error {
            self.errorMessage = error.localizedDescription
            completion(false, error)
            return
        }
        guard let user = result?.user else { return }
        self.user = user
        self.isSignedIn = true
        
        // Appelez checkForBabyInfo ici pour vous assurer que la vérification est effectuée immédiatement après l'authentification
        self.checkForBabyInfo()
        
        completion(true, nil)
    }
}
