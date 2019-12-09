//
//  LoginViewController.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 08/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//
// URL (KeyChain): https://github.com/jrendel/SwiftKeychainWrapper (installed with Cocoapods)

import UIKit
import SwiftKeychainWrapper

class AuthViewController: UIViewController {
    @IBOutlet var loginStackView: UIStackView!
    @IBOutlet var loginEmailTextField: UITextField!
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
        
        let loginEmailValidationResponse =  validator.validate(input: loginEmailTextField, with: [.notEmpty])
        let loginPasswordValidationResponse = validator.validate(input: loginPasswordTextField, with: [.notEmpty])
        
        if !loginEmailValidationResponse || !loginPasswordValidationResponse {
            errorMessages.append("Form validatie fouten")
            for error in errorMessages {
                setErrorInLabel(label: 1, error: error)
            }
        } else {
            apollo.perform(mutation: LoginMutation(input: UserInput.init(password: loginPasswordTextField.text!, email: loginEmailTextField.text!))) { result in
                guard let data = try? result.get().data?.login else { return }
                if ((data.errors?[0]) != nil) {
                    self.setErrorInLabel(label: 1, error: data.errors![0].message)
                } else {
                    // Successful login -> navigate to home and set user to logged in with KeyChainWrapper
                    self.performSegue(withIdentifier: "HomeSegue", sender: nil)
                    self.setLoggedIn(accessToken: data.accessToken!, key: "accessToken")
                }
            }
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        errorMessages = []
        
        let registerEmailValidationResponse =  validator.validate(input: registerEmailTextField, with: [.notEmpty])
        let registerPasswordValidationResponse = validator.validate(input: registerPasswordTextField, with: [.notEmpty])
        let registerRepeatPasswordValidationResponse = validator.validate(input: registerRepeatPasswordTextField, with: [.notEmpty])
        
        if !registerEmailValidationResponse || !registerPasswordValidationResponse || !registerRepeatPasswordValidationResponse {
            errorMessages.append("Form validatie fouten")
            for error in errorMessages {
                setErrorInLabel(label: 0, error: error)
            }
        } else {
            apollo.perform(mutation: RegisterMutation(input: UserInput.init(password: registerPasswordTextField.text!, email: registerEmailTextField.text!, repeatPassword: registerRepeatPasswordTextField.text!))) { result in
                guard let data = try? result.get().data else { return }
                
                if ((data.register.errors?[0]) != nil) {
                    self.setErrorInLabel(label: 0, error: data.register.errors![0].message)
                } else {
                   // Successful login -> navigate to home and set user to logged in with UserDefaults
                    self.performSegue(withIdentifier: "HomeSegue", sender: nil)
                    self.setLoggedIn(accessToken: "fsefe", key: "accessToken")
                }
            }
        }
    }
    
    func setErrorInLabel(label: Int, error: String) {
        errorLabels[label].alpha = 1
        errorLabels[label].text = error
    }
    
    func setLoggedIn(accessToken: String, key: String) {
        KeychainWrapper.standard.set(accessToken, forKey: key)
    }
}
