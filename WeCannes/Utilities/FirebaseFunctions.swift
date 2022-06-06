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
    
    // MARK: Auth Functions
    func registerUser(email: String, password: String, name: String, company: String, title: String, phone: String, completion: @escaping (Bool, Error?) -> Void) {
        utilities.showActivityIndicator()
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if (error != nil) {
                self.utilities.stopActivityIndicator()
                completion(false, error)
            } else{
                if let uid = authResult?.user.uid as? String {
                    self.utilities.storeValue(key: "uid", value: uid) {
                        self.storeUser(name: name, uid: uid, company: company, title: title, phone: phone)
                        self.utilities.stopActivityIndicator()
                        completion(true, error)
                    }
                }
            }
        }
    }
    
    func signIn(vc: UIViewController, email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        utilities.showActivityIndicator()
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if (error != nil) {
                self.utilities.stopActivityIndicator()
                if let err = error as? NSError {
                    let errCode = AuthErrorCode(_nsError: err).code
                    self.utilities.handleFirebaseAuthError(error: errCode, vc: vc)
                }
                completion(false, error)
            } else{
                self.utilities.stopActivityIndicator()
                self.store.set(true, forKey: "Authenticated")
                guard let uid = authResult?.user.uid as? String else { return }
                self.store.setValue(uid, forKey: "UID")
                completion(true, error)
            }
        }
    }
    
    func recoverPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    // MARK: Retrieve Data
    func getCollectionData(collection: String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        utilities.showActivityIndicator()
        Firestore.firestore().collection(collection).getDocuments(completion: { (documents, error) in
            self.utilities.stopActivityIndicator()
            completion(documents, error)
        })
    }
    
    // MARK: Helpers
    private func storeUser(name: String, uid: String, company: String, title: String, phone: String) {
        let collection = Firestore.firestore().collection("users")
        let user = ["uid": uid, "name": name, "company": company, "title": title, "phone": phone, "ar_id": self.utilities.randomString(length: 3), "points": 0] as [String : Any]
        collection.addDocument(data: user)
        store.set(true, forKey: "Authenticated")
        store.setValue(uid, forKey: "UID")
        utilities.storeValue(key: "Name", value: name) {
            return
        }
    }
}
