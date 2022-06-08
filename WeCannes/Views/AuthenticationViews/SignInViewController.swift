//
//  SignInViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/21/22.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    private let firebaseFunctions = FirebaseFunctions()
    private let util = Utilities.init()
    
    override func viewWillAppear(_ animated: Bool) {
        util.updateButtonStyle(button: loginButton, title: "Sign In")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func signInAction(_ sender: Any) {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        if !util.validateInput(value: email) {
            util.displayAlert(vc: self, message: "That's not a valid email.", title: "Whoops")
            return
        }
        
        firebaseFunctions.signIn(vc: self, email: email, password: password) { authResult, error in
            if error == nil {
                StoryboardLogic.init().tabBarSegue()
            }
        }
    }
}
