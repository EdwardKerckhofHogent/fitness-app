//
//  UserManager.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 10/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class UserManager {
    static let shared = UserManager()
    
    private let auth = Auth()
    private let accessTokenKey = "accessToken"
    
    var currentAuthToken: String? = {
        return KeychainWrapper.standard.string(forKey: "accessToken")
    }()

    func isLoggedIn() -> Bool {
        if currentAuthToken != nil {
            return true
        }
        return false
    }
}
