//
//  Utilities.swift
//  WeCannes
//
//  Created by Dustin Allen on 6/1/22.
//

import Foundation
import UIKit
import SafariServices

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
    
    func updateButtonStyle(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.infillionBlack, for: .normal)
        button.tintColor = UIColor.infillionGreen
    }
    
    func dynamicallyChangeButtonSize(button: UIButton) {
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.50
    }
    
    func showTutorial(theUrl: String) -> SFSafariViewController {
        if let url = URL(string: theUrl) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            return vc
//            present(vc, animated: true)
        }
        return SFSafariViewController.init(url: URL(string: "")!)
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
