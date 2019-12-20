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
    
    var routine: Routine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for ex in routine!.exercises {
            print(ex.name)
        }
        
        // Get routine by id from db
        
        routineNameLabel.text = routine!.name
        
        exercisesTableView.delegate = self
        exercisesTableView.dataSource = self
    }

}

extension EditViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routine!.exercises[section].sets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = exercisesTableView.dequeueReusableCell(withIdentifier: "ExerciseSetCell") as! ExerciseSetTableViewCell
        
        cell.cellTitle.text = "Set: \(indexPath.row + 1)"
        
        let exerciseCount = routine!.exercises.count
        var i = 0
        for set in routine!.exercises[i].sets {
            cell.amountKGTextField.text = String(set.kg)
            cell.amountRepsTextField.text = String(set.reps)
            
            if i < exerciseCount {
                i += 1
            }
        }
        
        
        
        return cell
    }
    
    // Make rows editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return routine!.exercises.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = routine!.exercises[section].name
        label.font = UIFont(name: "Montserrat", size: 18)
        label.backgroundColor = UIColor.white
        label.textColor = UIColor(red:0.16, green:0.56, blue:0.10, alpha:1.0)
        return label
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            routine!.exercises.remove(at: indexPath.row)
            
            exercisesTableView.beginUpdates()
            exercisesTableView.deleteRows(at: [indexPath], with: .automatic)
            
            exercisesTableView.endUpdates()
        }
    }

}
