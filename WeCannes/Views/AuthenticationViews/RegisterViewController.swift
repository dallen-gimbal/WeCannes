//
//  RegisterViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/21/22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func submitRegistration(_ sender: Any) {
        registerUser(email: emailField.text!, password: passwordField.text!)
    }
    

    // MARK: - Firebase
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if (error != nil) {
                print(error as Any)
            } else{
                print(authResult?.user.uid as Any)
            }
        }
    }
}
