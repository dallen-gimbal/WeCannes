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
import FirebaseAuth
import Gimbal

class Utilities {

    private let emailPattern = #"^\S+@\S+\.\S+$"#
    private let user = UserDefaults.init()
    private let placeManager = PlaceManager()
    
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
    
    func checkPointValue(key: String) -> Int {
        return user.integer(forKey: "Points")
    }
    
    func storePoints(value: String, completion: () -> ()) {
        user.set(calculatePoints(value:value), forKey: "Points")
        completion()
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
    func displayAlert(vc: UIViewController, message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog(message)
        }))
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: Points & Scoring
    // Handle Dwell Time Logic
    func dwellTimeMultiplier(points: String, dwell: Int) -> Int {
        let score = Int(points) ?? 0
        if dwell < 120 {
            return score
        } else if dwell >= 120 && dwell < 240 {
            return score * 2
        } else if dwell >= 120 && dwell < 240 {
            return score * 3
        } else if dwell >= 120 && dwell < 240 {
            return score * 4
        }
        return score * 5
    }
    
    // MARK: Errors
    func handleFirebaseAuthError(error: FirebaseAuth.AuthErrorCode.Code, vc: UIViewController) {
        if error == .userNotFound || error == .invalidEmail || error == .missingEmail || error == .wrongPassword {
            displayAlert(vc: vc, message: "There was an issue authenticating your information.", title: "Whoops")
        } else if error == .weakPassword {
            displayAlert(vc: vc, message: "That password is too weak, please enter a stronger password.", title: "Whoops")
        } else if error == .credentialAlreadyInUse || error == .emailAlreadyInUse {
            displayAlert(vc: vc, message: "There is already an account matching those details.", title: "Whoops")
        } else if error == .networkError || error == .webNetworkRequestFailed {
            displayAlert(vc: vc, message: "There seems to be network connectivity issues.", title: "Whoops")
        } else {
            displayAlert(vc: vc, message: "Some unkonwn error has occurred.", title: "Whoops")
        }
    }
    
    // MARK: Helpers
    private func calculatePoints(value: String) -> Int {
        let points = checkValue(key: "Points")
        if points != "" {
            let oldPoints = Int(points) ?? 0
            let newPoints = Int(value) ?? 0
            return oldPoints + newPoints
        }
        return 0
    }
}

// MARK: Extensions
extension UIColor {
    class var infillionBlack:UIColor {
        return UIColor.init(red: 22/255, green: 29/255, blue: 36/255, alpha: 1.0)
    }
    class var infillionGreen:UIColor {
        return UIColor.init(red: 0/255, green: 195/255, blue: 71/255, alpha: 1.0)
    }
}

extension UIView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func showFlip(){
        if self.isHidden{
            UIView.transition(with: self, duration: 1, options: [.transitionFlipFromRight,.allowUserInteraction], animations: nil, completion: nil)
            self.isHidden = false
        }
    }
}
