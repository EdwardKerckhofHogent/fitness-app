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
    var exercises: [Exercise]?
    
    init(name: String, exercises: [Exercise]?) {
        self.name = name
        self.exercises = exercises
    }
}
