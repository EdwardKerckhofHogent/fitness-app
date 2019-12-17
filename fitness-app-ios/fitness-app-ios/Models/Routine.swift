//
//  Routine.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 13/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import Foundation

struct Routine {
    var name: String
    var exercises: [MeQuery.Data.Me.User.Routine.Exercise]?
    
    init(routine: MeQuery.Data.Me.User.Routine) {
        self.name = routine.name
        self.exercises = routine.exercises ?? []
    }
}
