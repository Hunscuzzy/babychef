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
    @Published var isLoading: Bool = false
    
    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let self = self else { return }

            if let user = user {
                self.user = user
                self.isSignedIn = true
            } else {
                self.user = nil
                self.isSignedIn = false
            }
            self.checkForBabyInfo()
        }
    }

    deinit {
        // Suppression de l'écouteur lorsque le ViewModel est détruit
        if let handle = authStateDidChangeListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        self.isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.handleAuthResult(result: result, error: error, completion: completion)
        }
        self.isLoading = false
    }

    func signUp(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        self.isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            self.handleAuthResult(result: result, error: error, completion: completion)
        }
        self.isLoading = false
    }

    func signOut() {
        self.isLoading = true
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isSignedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            self.errorMessage = signOutError.localizedDescription
        }
        self.isLoading = false
    }
    
    func updateBabyInfo(firstName: String, birthDate: Date, gender: String, completion: @escaping (Bool, Error?) -> Void) {
        self.isLoading = true
        guard let user = user else { return }

        let db = Firestore.firestore()
        let babyInfo: [String: Any] = [
            "firstName": firstName,
            "birthDate": birthDate,
            "gender": gender
        ]

        db.collection("users").document(user.uid).setData(["babyInfo": babyInfo], merge: true) { error in
            if let error = error {
                completion(false, error)
                return
            }
            
            // Mettre à jour la valeur de hasBabyInfo
            self.hasBabyInfo = true

            completion(true, nil)
        }
        self.isLoading = false
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
    
    
    func completeSignUp(email: String, password: String, firstName: String, gender: String, birthDate: Date, completion: @escaping (Bool, Error?) -> Void) {
        self.isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Erreur lors de la création de l'utilisateur: \(error.localizedDescription)")
                completion(false, error)
                return
            }

            guard let user = result?.user else {
                print("Utilisateur non disponible")
                completion(false, nil)
                return
            }

            let db = Firestore.firestore()
            let uid = user.uid

            // Enregistrez les informations sous un champ appelé "account"
            let accountInfo: [String: Any] = [
                "firstName": firstName,
                "gender": gender,
                "birthDate": birthDate
            ]

            db.collection("users").document(uid).setData(["account": accountInfo], merge: true) { (error) in
                if let error = error {
                    print("Erreur lors de l'ajout des données: \(error.localizedDescription)")
                    completion(false, error)
                } else {
                    print("Données ajoutées avec succès.")
                    completion(true, nil)
                }
            }
        }
        self.isLoading = false
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
