//
//  Utilities.swift
//  WeCannes
//
//  Created by Dustin Allen on 6/1/22.
//

import Foundation

class Utilities {
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    // MARK: User Defaults
    func storeValue(key: String, value: String, completionBlock: () -> ()) {
        let user = UserDefaults.init()
        user.setValue(value, forKey: key)
        completionBlock()
    }
    
    func checkValue(key: String) -> String {
        return UserDefaults.init().string(forKey: key) ?? ""
    }
}
