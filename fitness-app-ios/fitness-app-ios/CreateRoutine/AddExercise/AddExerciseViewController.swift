//
//  AddExerciseViewController.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 16/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import UIKit

class AddExerciseViewController: UIViewController {
    @IBOutlet var introTextLabel: UILabel!
    @IBOutlet var setsTableView: UITableView!
    @IBOutlet var exerciseName: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    let networkManager = NetworkManager.shared
    let validator = Validator()
    
    var exerciseSets: [ExerciseSet] = []
    var givenExercises: [Exercise]?
    var routineName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackToRoutineSegue" {
            if let destinationVC = segue.destination as? CreateRoutineViewController {
                destinationVC.exercises = givenExercises!
                destinationVC.routineName = routineName!
            }
        }
    }
    
    @IBAction func addSetButtonTapped(_ sender: Any) {
        setsTableView.isHidden = false
        insertNewSet()
    }
    
    @IBAction func saveExerciseButtonTapped(_ sender: Any) {
        if validateExerciseName() {
            // Get sets
            var userExerciseSets: [ExerciseSet] = []
            for (index, _) in exerciseSets.enumerated() {
                let cell = setsTableView.cellForRow(at: IndexPath.init(row: index, section: 0)) as! ExerciseSetTableViewCell
                
                let kg = cell.amountKGTextField.text == "" ? "0" : cell.amountKGTextField.text
                let reps = cell.amountRepsTextField.text == "" ? "0" : cell.amountRepsTextField.text
                
                userExerciseSets.append(ExerciseSet(kg: Double(kg!)!, reps: Double(reps!)!))
            }
            let exercise = Exercise(name: exerciseName.text!, sets: userExerciseSets)
            givenExercises?.append(exercise)
            performSegue(withIdentifier: "BackToRoutineSegue", sender: nil)
        } else {
            errorLabel.alpha = 1
            errorLabel.text = "Oefening moet een naam hebben!"
        }
    }
    
    func insertNewSet() {
        exerciseSets.append(ExerciseSet(kg: 0, reps: 0))
        let indexPath = IndexPath(row: exerciseSets.count - 1, section: 0)
        setsTableView.beginUpdates()
        setsTableView.insertRows(at: [indexPath], with: .automatic)
        setsTableView.endUpdates()
    }
    
    func validateExerciseName() -> Bool {
        let exerciseNameValidationResponse = validator.validate(input: exerciseName, with: [.notEmpty])
        if !exerciseNameValidationResponse {
            return false
        } else {
            return true
        }
    }
    
    func updateUI() {
        errorLabel.alpha = 0
        
        // set tableview delegate
        setsTableView.isHidden = true
        setsTableView.delegate = self
        setsTableView.dataSource = self
        setsTableView.allowsSelection = false
        
        let colorWord = "workout"
        let customGreen = UIColor(red:0.16, green:0.56, blue:0.10, alpha:1.0)
        
        // Color word in string
        // URL: https://stackoverflow.com/questions/39665423/how-to-change-colour-of-the-certain-words-in-label-swift-3
        let introString = "Voeg een oefening toe aan jouw workout routine"
        let range = (introString as NSString).range(of: colorWord)
        let attributedText = NSMutableAttributedString.init(string: introString)
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: customGreen, range: range)
        introTextLabel.attributedText = attributedText
    }
}

extension AddExerciseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseSets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = setsTableView.dequeueReusableCell(withIdentifier: "ExerciseSetCell") as! ExerciseSetTableViewCell
        cell.setExerciseSet(index: indexPath .row)
        return cell
    }
    
    // Make rows editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            exerciseSets.remove(at: indexPath.row)
            
            setsTableView.beginUpdates()
            setsTableView.deleteRows(at: [indexPath], with: .automatic)
            
            if exerciseSets.count == 0 {
                setsTableView.isHidden = true
            }
            
            setsTableView.endUpdates()
        }
    }
}
