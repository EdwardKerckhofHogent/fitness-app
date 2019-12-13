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
    
    let networkManager = NetworkManager.shared
    var accessToken: String = ""
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.apollo.fetch(query: MeQuery()) { result in
            guard let data = try? result.get().data?.me else {
                print("Server Error: Cannot get me")
                return
            }
            if ((data.errors?[0]) != nil) {
                print(data.errors![0].message)
            } else {
                var userRoutines: [Routine] = []
                
                for routine in data.user!.routines ?? [] {
                    userRoutines.append(Routine(name: routine.name, userId: routine.userId))
                }
                
                self.user = User(id: data.user!.id, email: data.user!.email, routines: userRoutines)
            }
        }

        headerView.logoutButton.isHidden = false
        headerView.logoutButton.addTarget(self, action: #selector (logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc func logoutButtonTapped(_ sender: UIButton) {
        print("Logout from home")
        networkManager.apollo.perform(mutation: LogoutMutation(userId: Double(user!.id))) { result in
            guard let _ = try? result.get().data else {
                print("User Logout Error")
                return
            }
            self.networkManager.logUserOut()
            self.performSegue(withIdentifier: "LogoutSegue", sender: nil)
        }
    }
}
