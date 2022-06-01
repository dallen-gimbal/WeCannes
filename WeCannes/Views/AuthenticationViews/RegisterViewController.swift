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
    
    private let firebaseFunctions = FirebaseFunctions()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func submitRegistration(_ sender: Any) {
        if firebaseFunctions.registerUser(email: emailField.text!, password: passwordField.text!) {
            print("True")
            firebaseFunctions.storeUser(name: "John Doe")
        }
    }
    
}
