//
//  LoginViewController.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 08/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    @IBOutlet var loginStackView: UIStackView!
    @IBOutlet var registerStackView: UIStackView!
    @IBOutlet var goToRegistrationButton: UIButton!
    @IBOutlet var goToLoginButton: UIButton!
    @IBOutlet var errorLabels: [UILabel]!
    
    var hideRegister: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func switchActionButtonTapped(_ sender: UIButton) {
        hideRegister.toggle()
        updateUI()
    }
    
    func updateUI() {
        for label in errorLabels {
            label.alpha = 0
        }
        loginStackView.isHidden = !hideRegister
        registerStackView.isHidden = hideRegister
    }
}
