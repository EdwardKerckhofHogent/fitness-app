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
    var routines: [MeQuery.Data.Me.User.Routine]
    var nickname: String
    
    init(user: MeQuery.Data.Me.User) {
        self.id = user.id
        self.email = user.email
        self.routines = user.routines ?? []
        self.nickname = String(user.email.split(separator: "@")[0])
    }
}
