//
//  Utilities.swift
//  WeCannes
//
//  Created by Dustin Allen on 6/1/22.
//

import Foundation
import UIKit
import SafariServices
import IHProgressHUD

class Utilities {

    private let emailPattern = #"^\S+@\S+\.\S+$"#
    private let user = UserDefaults.init()
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    // MARK: User Defaults
    func storeValue(key: String, value: String, completionBlock: () -> ()) {
        user.setValue(value, forKey: key)
        completionBlock()
    }
    
    func checkValue(key: String) -> String {
        return user.string(forKey: key) ?? ""
    }
    
    // MARK: Buttons
    func updateButtonStyle(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.infillionBlack, for: .normal)
        button.tintColor = UIColor.infillionGreen
    }
    
    func dynamicallyChangeButtonSize(button: UIButton) {
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.50
    }
    
    // MARK: Onboarding
    func showTutorial(theUrl: String) -> SFSafariViewController {
        if let url = URL(string: theUrl) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            return vc
        }
        return SFSafariViewController.init(url: URL(string: "")!)
    }
    
    // MARK: Progress Indicator
    func showActivityIndicator(){
        DispatchQueue.main.async {
            IHProgressHUD.show()
        }
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            IHProgressHUD.dismiss()
        }
    }
    
    // MARK: Input Validator
    func validateInput(value: String) -> Bool {
        let result = value.range(
            of: emailPattern,
            options: .regularExpression
        )
        return result != nil ? true : false
    }
    
    // MARK: UIAlert
    func displayAlert(vc: UIViewController, type: String) {
        let alert = UIAlertController(title: "Whoops", message: "That's not a valid \(type).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \(type) alert occured.")
        }))
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
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
