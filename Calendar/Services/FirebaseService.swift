//
//  FirebaseService.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class FirebaseService {
    private var database: Firestore!
    private var auth: Auth!
    static let shared = FirebaseService()
    
    // MARK: - Initializer
    init() {
        database = Firestore.firestore()
        auth = Auth.auth()
    }
}

// MARK: - Authentication
extension FirebaseService : Authentication {
    func createUser(email: String, password: String, completion: @escaping (Error?) -> ()) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                completion(error)
                return
            }
            self.logUserIn(withEmail: email, password: password) { loginError in
                if let loginError = loginError {
                    completion(loginError)
                    return
                }
                completion(nil)
            }
        }
    }
    
    func logUserIn(withEmail email: String, password: String, completion: @escaping (Error?) -> ()) {
        auth.signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                completion(error)
                return
            }
            print("Successfully log user into firebase")
            completion(nil)
        }
    }
    
    func logout() {
        do {
            try auth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

// MARK: - Database
extension FirebaseService : Database {
    
}
