//
//  CustomTabBarController.swift
//  WeCannes
//
//  Created by Dustin Allen on 6/2/22.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }

}
