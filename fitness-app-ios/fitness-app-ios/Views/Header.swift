//
//  Header.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 08/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import UIKit

class Header: UIView {
    @IBOutlet var headerView: UIView!
    @IBOutlet var logoutButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadViewFromNib() else { return }
        
        let loggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        if loggedIn {
            logoutButton.isHidden = false
        } else {
            logoutButton.isHidden = true
        }
        
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "Header", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
