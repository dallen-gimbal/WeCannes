//
//  FirebaseFunctions.swift
//  WeCannes
//
//  Created by Dustin Allen on 6/1/22.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class FirebaseFunctions {
    private var ref: DatabaseReference!
    private var user = UserDefaults.standard
    private var error = false
    
    // MARK: Authentication
    func registerUser(email: String, password: String) -> Bool {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if (error != nil) {
                print(error as Any)
            } else{
                if let uid = authResult?.user.uid as? String {
                    self.user.setValue(uid, forKey: "uid")
                }
            }
        }
        if error {
            print(error)
            return false
        }
        return true
    }
    
    func signIn(email: String, password: String) -> Bool {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if (error != nil) {
                print(error as Any)
            } else{
                print(authResult?.user.uid as Any)
                self.user.setValue(authResult?.user.uid, forKey: "uid")
            }
        }
        if (error) {
            return false
        }
        return true
    }
    
    // MARK: Database
    func storeUser(name: String) {
        guard let uid = user.object(forKey: "uid") as? String else { return }
        print("UID: \(uid)")
        ref = Database.database().reference()
        ref.child("users").child(uid).setValue(["test":name]) {
        (error:Error?, ref:DatabaseReference) in
          if let error = error {
            print("Data could not be saved: \(error).")
          } else {
            print("Data saved successfully!")
          }
        }
    }
    

    // MARK: Helpers
}
