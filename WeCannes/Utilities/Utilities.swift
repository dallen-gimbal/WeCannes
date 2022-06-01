//
//  Utilities.swift
//  WeCannes
//
//  Created by Dustin Allen on 6/1/22.
//

import Foundation
import UIKit

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

extension UIColor {
    class var infillionBlack:UIColor {
        return UIColor.init(red: 22/255, green: 29/255, blue: 36/255, alpha: 1.0)
    }
    class var infillionGreen:UIColor {
        return UIColor.init(red: 0/255, green: 195/255, blue: 71/255, alpha: 1.0)
    }
}
