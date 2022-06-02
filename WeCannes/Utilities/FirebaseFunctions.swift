//
//  FirebaseFunctions.swift
//  WeCannes
//
//  Created by Dustin Allen on 6/1/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import UIKit

class FirebaseFunctions {
    
    private let utilities = Utilities.init()
    private let store = UserDefaults.init()
    
    // MARK: Main Functions
    func registerUser(email: String, password: String, name: String, company: String, title: String, phone: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if (error != nil) {
                print(error as Any)
            } else{
                if let uid = authResult?.user.uid as? String {
                    print("UID: \(uid)")
                    self.utilities.storeValue(key: "uid", value: uid) {
                        self.storeUser(name: name, uid: uid, company: company, title: title, phone: phone)
                    }
                }
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if (error != nil) {
                print(error as Any)
                completion(false, error)
            } else{
                self.store.set(true, forKey: "Authenticated")
                completion(true, error)
            }
        }
    }
    
    // MARK: Helpers
    private func storeUser(name: String, uid: String, company: String, title: String, phone: String) {
        let collection = Firestore.firestore().collection("users")
        let user = ["uid": uid, "name": name, "company": company, "title": title, "phone": phone, "ar_id": self.utilities.randomString(length: 3)]
        collection.addDocument(data: user)
        store.set(true, forKey: "Authenticated")
    }
    
    private func segueStoryboard() {
        
    }
}
