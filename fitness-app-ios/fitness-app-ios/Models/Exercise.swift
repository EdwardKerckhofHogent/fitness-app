//
//  Exercise.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 16/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import Foundation

struct Exercise {
    var name: String
    var sets: [MeQuery.Data.Me.User.Routine.Exercise.Set]
    
    init(exercise: MeQuery.Data.Me.User.Routine.Exercise) {
        self.name = exercise.name
        self.sets = exercise.sets ?? []
    }
}
