//
//  Header.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 08/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import UIKit

class Header: UIView {
    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var welcomeText: UIStackView!
    @IBOutlet var welcomeName: UILabel!
    
    var loggedInUser: User?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadViewFromNib() else { return }
        
        loggedInUser = NetworkManager.shared.getLoggedInUser()
        logoutButton.isHidden = true
        welcomeText.isHidden = true
        
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "Header", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    @objc func logoutButtonTapped(_ sender: UIButton) {
        NetworkManager.shared.apollo.perform(mutation: LogoutMutation(userId: Double(self.loggedInUser!.id))) { result in
            guard let _ = try? result.get().data else {
                print("User Logout Error")
                return
            }
            self.loggedInUser = nil
            self.logoutButton.isHidden = true
            self.welcomeText.isHidden = true
            NetworkManager.shared.logUserOut()
        }
    }
}
