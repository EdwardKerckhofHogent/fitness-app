//
//  HomeRoutineTableViewCell.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 16/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import UIKit

class HomeRoutineTableViewCell: UITableViewCell {
    @IBOutlet var routineNameLabel: UILabel!
    
    func setRoutineName(name: String) {
        routineNameLabel.text = name
    }
}
