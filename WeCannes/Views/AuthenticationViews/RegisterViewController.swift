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
    
    private let firebaseFunctions = FirebaseFunctions()
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(UIColor.infillionBlack, for: .normal)
        registerButton.tintColor = UIColor.infillionGreen
    }
    
    
    @IBAction func submitRegistration(_ sender: Any) {
        firebaseFunctions.registerUser(email: emailField.text!, password: passwordField.text!, name: "Dustin", company: "Infillion", title: "PM", phone: "123456789")
    }
    
}
