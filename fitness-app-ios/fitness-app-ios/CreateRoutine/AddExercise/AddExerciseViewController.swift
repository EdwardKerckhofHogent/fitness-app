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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackToRoutineSegue" {
            if let destinationVC = segue.destination as? CreateRoutineViewController {
                destinationVC.exercises = givenExercises!
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
                userExerciseSets.append(ExerciseSet(kg: Double(cell.amountKGTextField.text!)!, reps: Double(cell.amountRepsTextField.text!)!))
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
    
    
    /*
    func addNewExercise() {
        networkManager.apollo.perform(mutation: AddExerciseMutation(input: ExerciseInput.init(name: exerciseName.text!, routineId: Double(routineId!)))) { result in
            guard let data = try? result.get().data?.addExercise else {
                print("Server Error: Cannot add exercise")
                return
            }
            if ((data.errors?[0]) != nil) {
                print(data.errors![0].message)
            } else {
                self.oldName = self.exerciseName.text!
                self.exercise = Exercise(exercise: data.exercise!)
                self.created = true
            }
        }
    }
    
    func deleteOldExercise() {
        
    }
    
    func addSetToExercise(kg: Double, reps: Double, exerciseId: Int) {
        networkManager.apollo.perform(mutation: AddSetMutation(input: SetInput.init(kg: kg, reps: reps, exerciseId: Double(exerciseId)))) { result in
            guard let _ = try? result.get().data?.addSet else {
                print("Server Error: Cannot add set to exercise")
                return
            }
        }
    }*/
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
