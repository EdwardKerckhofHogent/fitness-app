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
    @IBOutlet var routinesButton: UIButton!
    
    let networkManager = NetworkManager.shared
    var accessToken: String = ""
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background image to right
        // URL: https://stackoverflow.com/questions/7100976/how-do-i-put-the-image-on-the-right-side-of-the-text-in-a-uibutton
        routinesButton.semanticContentAttribute = UIApplication.shared
        .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        
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
                    userRoutines.append(Routine(name: routine.name, exercises: []))
                }
                
                self.user = User(id: data.user!.id, email: data.user!.email, routines: userRoutines)
                self.networkManager.loggedInUser = self.user
                let createRoutineTab = self.tabBarController!.viewControllers![1] as! CreateRoutineViewController
                createRoutineTab.user = self.user
                self.updateUI()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let routines = user?.routines else { print("No routines")
            return
        }
        
        print(routines)
    }
    
    func updateUI() {
        self.headerView.welcomeText.isHidden = false
        self.headerView.welcomeName.text = self.user!.nickname.capitalizeFirstLetter() + "!"
        self.headerView.logoutButton.isHidden = false
        self.headerView.logoutButton.addTarget(self, action: #selector (self.logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc func logoutButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "LogoutSegue", sender: nil)
    }
}
