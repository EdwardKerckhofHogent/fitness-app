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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.logoutButton.isHidden = false
        headerView.logoutButton.addTarget(self, action: #selector (logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc func logoutButtonTapped(_ sender: UIButton) {
        print("Logout from home")
        Network.logUserOut()
        performSegue(withIdentifier: "LoginSegue", sender: nil)
    }
}
