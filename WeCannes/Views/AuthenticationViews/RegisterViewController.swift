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
    private let util = Utilities.init()
    
    override func viewWillAppear(_ animated: Bool) {
        Utilities.init().updateButtonStyle(button: registerButton, title: "Register")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func submitRegistration(_ sender: Any) {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        guard let name = nameField.text else { return }
        guard let company = companyField.text else { return }
        guard let title = titleField.text else { return }
        guard let phone = phoneField.text else { return }
        
        if !util.validateInput(value: email) {
            util.displayAlert(vc: self, message: "That's not a valid email.")
            return
        }
        
        firebaseFunctions.registerUser(email: email, password: password, name: name, company: company, title: title, phone: phone) { authResult, error in
            if error == nil {
                StoryboardLogic.init().onboardingSegue()
            }
        }
    }
    
}
