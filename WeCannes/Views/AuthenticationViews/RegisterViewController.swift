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
        firebaseFunctions.registerUser(email: emailField.text!, password: passwordField.text!, name: "Dustin", company: "Infillion", title: "PM", phone: "123456789")
    }
    
}
