//
//  RecoverPasswordViewController.swift
//  WeCannes
//
//  Created by Dustin Allen on 6/4/22.
//

import UIKit

class RecoverPasswordViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        Utilities.init().updateButtonStyle(button: passwordButton, title: "Recover Password")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
