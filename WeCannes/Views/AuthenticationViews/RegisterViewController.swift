//
//  RegisterViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/21/22.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    private let firebaseFunctions = FirebaseFunctions()
    
    class func instantiate() -> UIViewController {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "\(RegisterViewController.self)")

        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.init().updateButtonStyle(button: registerButton, title: "Register")
    }
    
    
    @IBAction func submitRegistration(_ sender: Any) {
        firebaseFunctions.registerUser(email: emailField.text!, password: passwordField.text!, name: "Dustin", company: "Infillion", title: "PM", phone: "123456789") { authResult, error in
            if authResult {
                StoryboardLogic.init().onboardingSegue()
            }
        }
    }
    
}
