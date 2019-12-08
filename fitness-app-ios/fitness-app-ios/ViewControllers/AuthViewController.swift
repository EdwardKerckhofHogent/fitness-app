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
    @IBOutlet var loginEmailTexField: UITextField!
    @IBOutlet var loginPasswordTextField: UITextField!
    @IBOutlet var goToRegistrationButton: UIButton!
    
    @IBOutlet var registerStackView: UIStackView!
    @IBOutlet var registerEmailTextField: UITextField!
    @IBOutlet var registerPasswordTextField: UITextField!
    @IBOutlet var registerRepeatPasswordTextField: UITextField!
    @IBOutlet var goToLoginButton: UIButton!
    
    @IBOutlet var errorLabels: [UILabel]!
    
    let apollo = Network.shared.apollo
    let validator = Validator()
    var hideRegister: Bool = true
    var errorMessages: [String] = []
    
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
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        errorMessages = []
        
        let loginEmailValidationResponse =  validator.validate(input: loginEmailTexField, with: [.notEmpty])
        
        let loginPasswordValidationResponse = validator.validate(input: loginPasswordTextField, with: [.notEmpty])
        
        if !loginEmailValidationResponse || !loginPasswordValidationResponse {
            errorMessages.append("Form validatie fouten")
            for error in errorMessages {
                setErrorInLabel(label: 1, error: error)
            }
        } else {
            print("Login")
            apollo.perform(mutation: LoginMutation(input: UserInput.init(password: loginPasswordTextField.text!, email: loginEmailTexField.text!))) { result in
                guard let data = try? result.get().data else { return }
                if data.login == nil {
                    self.setErrorInLabel(label: 1, error: "Verkeerd email/wachtwoord")
                } else {
                    // Successful login -> navigate to home
                    self.performSegue(withIdentifier: "HomeSegue", sender: nil)
                }
            }
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        print("Register")
    }
    
    func setErrorInLabel(label: Int, error: String) {
        errorLabels[label].alpha = 1
        errorLabels[label].text = error
    }
}
