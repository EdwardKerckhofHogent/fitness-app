//
//  EditViewController.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 20/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet var routineNameLabel: UILabel!
    @IBOutlet var exercisesTableView: UITableView!
    
    let networkManager = NetworkManager.shared
    var routine: Routine?
    var dbRoutine: Routine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(routine!.id)
        
        // Get routine by id from db
        networkManager.apollo.fetch(query: GetRoutineByIdQuery(input: Double(routine!.id))) { result in
            guard let data = try? result.get().data?.getRoutine else {
                print("Server Error: Cannot get routine")
                return
            }
            
            if data.errors?[0] != nil {
                print(data.errors![0].message)
            } else {
                var routineExercises: [Exercise] = []
                var exerciseSets: [ExerciseSet] = []
                for exercise in data.routine!.exercises! {
                    for set in exercise.sets! {
                        exerciseSets.append(ExerciseSet(kg: set.kg, reps: set.reps))
                    }
                    routineExercises.append(Exercise(name: exercise.name, sets: exerciseSets))
                    exerciseSets = []
                }
                
                self.dbRoutine = Routine(id: data.routine!.id, name: data.routine!.name, exercises: routineExercises)
                self.exercisesTableView.reloadData()
            }
        }
        
        routineNameLabel.text = routine!.name
        
        exercisesTableView.delegate = self
        exercisesTableView.dataSource = self
    }

}

extension EditViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dbRoutine!.exercises[section].sets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = exercisesTableView.dequeueReusableCell(withIdentifier: "ExerciseSetCell") as! ExerciseSetTableViewCell
        
        cell.cellTitle.text = "Set: \(indexPath.row + 1)"
        
        var sets: [ExerciseSet] = []
        
        for set in dbRoutine!.exercises[indexPath.section].sets {
            sets.append(ExerciseSet(kg: set.kg, reps: set.reps))
        }
        
        cell.amountKGTextField.text = "\(sets[indexPath.row].kg)"
        cell.amountRepsTextField.text = "\(sets[indexPath.row].reps)"
        
        return cell
    }
    
    // Make rows editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dbRoutine?.exercises.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = dbRoutine!.exercises[section].name
        label.font = UIFont(name: "Montserrat", size: 18)
        label.backgroundColor = UIColor.white
        label.textColor = UIColor(red:0.16, green:0.56, blue:0.10, alpha:1.0)
        return label
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            dbRoutine!.exercises.remove(at: indexPath.row)
            
            exercisesTableView.beginUpdates()
            exercisesTableView.deleteRows(at: [indexPath], with: .automatic)
            
            exercisesTableView.endUpdates()
        }
    }

}
