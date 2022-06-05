//
//  CustomPage.swift
//  SwiftyOnboardExample
//
//  Created by Jay on 3/27/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit
import SwiftyOnboard

class OnboardingPage: SwiftyOnboardPage {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "OnboardingPage", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
}
