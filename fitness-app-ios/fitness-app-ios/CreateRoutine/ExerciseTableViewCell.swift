//
//  ExerciseTableViewCell.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 17/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    @IBOutlet var exerciseNumberLabel: UILabel!
    @IBOutlet var exerciseNameLabel: UILabel!
    
    func setExerciseCell(index: Int, exercise: Exercise) {
        exerciseNumberLabel.text = "OEF: \(index+1)"
        exerciseNameLabel.text = exercise.name
    }
}
