//
//  LoginViewController.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 08/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//
// URL (KeyChain): https://github.com/jrendel/SwiftKeychainWrapper (installed with Cocoapods)

import UIKit
import Apollo

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
    @IBOutlet var headerView: Header!
    
    let networkManager = NetworkManager.shared
    let validator = Validator()
    var hideRegister: Bool = true
    var errorMessages: [String] = []
    var accessToken: String?
    
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
        
        headerView.welcomeText.isHidden = true
        headerView.logoutButton.isHidden = true
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
            networkManager.apollo.perform(mutation: LoginMutation(input: UserInput.init(password: loginPasswordTextField.text!, email: loginEmailTextField.text!))) { result in
                guard let data = try? result.get().data?.login else {
                    self.setErrorInLabel(label: 1, error: "SERVER LOGIN ERROR")
                    return
                }
                if ((data.errors?[0]) != nil) {
                    self.setErrorInLabel(label: 1, error: data.errors![0].message)
                } else {
                    self.registerLogin(accessToken: data.accessToken!)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeSegue" {
            if let destinationVC = segue.destination as? HomeViewController {
                destinationVC.accessToken = accessToken!
            }
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        errorMessages = []
        
        let registerEmailValidationResponse =  validator.validate(input: registerEmailTextField, with: [.notEmpty, .minLength(length: 5)])
        let registerPasswordValidationResponse = validator.validate(input: registerPasswordTextField, with: [.notEmpty, .minLength(length: 5)])
        let registerRepeatPasswordValidationResponse = validator.validate(input: registerRepeatPasswordTextField, with: [.notEmpty, .minLength(length: 5)])
        
        if !registerEmailValidationResponse || !registerPasswordValidationResponse || !registerRepeatPasswordValidationResponse {
            errorMessages.append("Form validatie fouten")
            for error in errorMessages {
                setErrorInLabel(label: 0, error: error)
            }
        } else if registerRepeatPasswordTextField.text != registerPasswordTextField.text {
            setErrorInLabel(label: 0, error: "Wachtwoorden niet gelijk")
        } else {
            networkManager.apollo.perform(mutation: RegisterMutation(input: UserInput.init(password: registerPasswordTextField.text!, email: registerEmailTextField.text!, repeatPassword: registerRepeatPasswordTextField.text!))) { result in
                guard let data = try? result.get().data?.register else { return }
                
                if ((data.errors?[0]) != nil) {
                    self.setErrorInLabel(label: 0, error: data.errors![0].message)
                } else {
                   // Successful login -> navigate to home and set user to logged in with UserDefaults
                    self.registerLogin(accessToken: data.accessToken!)
                }
            }
        }
    }
    
    func registerLogin(accessToken: String) {
        self.accessToken = accessToken
        networkManager.logUserIn(accessToken: accessToken)
        performSegue(withIdentifier: "HomeSegue", sender: nil)
    }
    
    func setErrorInLabel(label: Int, error: String) {
        errorLabels[label].alpha = 1
        errorLabels[label].text = error
    }
}
