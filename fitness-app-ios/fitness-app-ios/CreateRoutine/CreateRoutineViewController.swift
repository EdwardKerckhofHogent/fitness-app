//
//  CreateRoutineViewController.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 14/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import UIKit

class CreateRoutineViewController: UIViewController {
    @IBOutlet var introTextLabel: UILabel!
    @IBOutlet var saveRoutineButton: UIButton!
    @IBOutlet var routineNameTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var exerciseTableView: UITableView!
    
    let networkManager = NetworkManager.shared
    let validator = Validator()
    var routineName: String?
    var exercises: [Exercise] = []
    var created: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("ja")
        print(exercises)
        exerciseTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddExerciseSegue" {
            if let destinationVC = segue.destination as? AddExerciseViewController {
                destinationVC.givenExercises = self.exercises
            }
        }
    }
    
    @IBAction func addExerciseButtonTapped(_ sender: UIButton) {
        //AddExercise
        self.performSegue(withIdentifier: "AddExerciseSegue", sender: nil)
    }
    
    @IBAction func saveRoutineButtonTapped(_ sender: UIButton) {
        if validateRoutineName() {
            addNewRoutine()
        } else {
            errorLabel.alpha = 1
            errorLabel.text = "Routine moet een naam hebben!"
        }
    }
    
    func validateRoutineName() -> Bool {
        let routineNameValidationResponse = validator.validate(input: routineNameTextField, with: [.notEmpty])
        if !routineNameValidationResponse {
            return false
        } else {
            return true
        }
    }
    
    func updateUI() {
        // set tableview delegate
        exerciseTableView.delegate = self
        exerciseTableView.dataSource = self
        exerciseTableView.allowsSelection = false
        
        errorLabel.alpha = 0
        let colorWord = "workout"
        let customGreen = UIColor(red:0.16, green:0.56, blue:0.10, alpha:1.0)
        
        // Color word in string
        // URL: https://stackoverflow.com/questions/39665423/how-to-change-colour-of-the-certain-words-in-label-swift-3
        let introString = "Stel een nieuwe workout routine samen!"
        let range = (introString as NSString).range(of: colorWord)
        let attributedText = NSMutableAttributedString.init(string: introString)
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: customGreen, range: range)
        introTextLabel.attributedText = attributedText
    }
    
    func addNewRoutine() {
        var exerciseInputs: [ExerciseInput] = []
        var exerciseSetInputs: [SetInput] = []
        for exercise in exercises {
            for set in exercise.sets {
                exerciseSetInputs.append(SetInput.init(kg: set.kg, reps: set.reps))
            }
            exerciseInputs.append(ExerciseInput.init(name: exercise.name, sets: exerciseSetInputs))
        }
        
        networkManager.apollo.perform(mutation: AddRoutineMutation(input: RoutineInput.init(name: routineNameTextField.text!, exercises: exerciseInputs))) { result in
            guard let data = try? result.get().data?.addRoutine else {
                print("Server Error: Cannot add routine")
                return
            }
            if ((data.errors?[0]) != nil) {
                print(data.errors![0].message)
            } else {
                self.performSegue(withIdentifier: "HomeSegue", sender: nil)
            }
        }
    }
    
    func deleteRoutine() {
        
    }
}

extension CreateRoutineViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exercise = exercises[indexPath.row]
        let cell = exerciseTableView.dequeueReusableCell(withIdentifier: "ExerciseCell") as! ExerciseTableViewCell
        cell.setExerciseCell(index: indexPath.row, exercise: exercise)
        return cell
    }
    
    // Make rows editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            exercises.remove(at: indexPath.row)
            
            exerciseTableView.beginUpdates()
            exerciseTableView.deleteRows(at: [indexPath], with: .automatic)
            
            if exercises.count == 0 {
                exerciseTableView.isHidden = true
            }
            
            exerciseTableView.endUpdates()
        }
    }
}
