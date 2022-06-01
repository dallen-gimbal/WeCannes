//
//  FirebaseFunctions.swift
//  WeCannes
//
//  Created by Dustin Allen on 6/1/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirebaseFunctions {
    
    private let utilities = Utilities.init()
    
    // MARK: Authentication
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
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if (error != nil) {
                print(error as Any)
            } else{
                print(authResult?.user.uid as Any)
//                storeValue(key: "uid", value: <#T##String#>, completionBlock: <#T##() -> ()#>)
            }
        }
    }
    
    // MARK: Database
    func storeUser(name: String, uid: String, company: String, title: String, phone: String) {
        let collection = Firestore.firestore().collection("users")
        let user = ["uid": uid, "name": name, "company": company, "title": title, "phone": phone, "ar_id": self.utilities.randomString(length: 3)]
        collection.addDocument(data: user)
    }
}
