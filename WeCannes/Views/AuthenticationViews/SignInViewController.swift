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
    
    private let firebaseFunctions = FirebaseFunctions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utilities.init().updateButtonStyle(button: loginButton, title: "Login")
    }
    
    
    @IBAction func signInAction(_ sender: Any) {
        firebaseFunctions.signIn(email: emailField.text!, password: passwordField.text!)
    }
}
