//
//  ExerciseSetTableViewCell.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 16/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import UIKit

class ExerciseSetTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet var cellTitle: UILabel!
    @IBOutlet var amountKGTextField: UITextField!
    @IBOutlet var amountKGLabel: UILabel!
    @IBOutlet var amountRepsTextField: UITextField!
    @IBOutlet var amountRepsLabel: UILabel!
    
    func setExerciseSet(index: Int) {
        amountKGTextField.delegate = self
        amountRepsTextField.delegate = self
        cellTitle.text = "SET: \(index+1)"
    }
    
    
    // Numbers only
    // URL: https://stackoverflow.com/questions/30973044/how-to-restrict-uitextfield-to-take-only-numbers-in-swift/30973490
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
      let allowedCharacters = CharacterSet.decimalDigits
      let characterSet = CharacterSet(charactersIn: string)
      return allowedCharacters.isSuperset(of: characterSet)
    }
}
