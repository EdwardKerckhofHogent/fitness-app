//
//  User.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 11/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import Foundation

struct User {
    var id: Int
    var email: String
    var routines: [Routine]
    lazy var nickname: String = {
        return String(email.split(separator: "@")[0])
    }()
    
    init(id: Int, email: String, routines: [Routine]) {
        self.id = id
        self.email = email
        self.routines = routines
    }
}
