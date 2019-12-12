//
//  HomeViewController.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 08/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var headerView: Header!
    
    let auth = Auth()
    var accessToken: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if accessToken != "" {
            NetworkManager.shared.setApolloClient(accessToken: accessToken)
        }
        
        auth.getMe(completion: { result in
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error)
            }
        })

        headerView.logoutButton.isHidden = false
        headerView.logoutButton.addTarget(self, action: #selector (logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc func logoutButtonTapped(_ sender: UIButton) {
        print("Logout from home")
        performSegue(withIdentifier: "LoginSegue", sender: nil)
        auth.logout(completion: { result in
            switch result {
            case .success(let val):
                print(val)
                
            case .failure(let error):
                print(error)
            }
        })
    }
}
