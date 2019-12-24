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
    @IBOutlet var saveRoutineButton: UIButton!
    @IBOutlet var startRoutineButton: UIButton!
    @IBOutlet var newNameTextField: UITextField!
    
    let networkManager = NetworkManager.shared
    var routine: Routine?
    var dbRoutine: Routine?
    var newRoutineName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(routine!.id)
        
        // Get routine by id from db
        let watcher = networkManager.apollo.watch(query: GetRoutineByIdQuery(input: Double(routine!.id))) { result in
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
                self.newRoutineName = data.routine!.name
                self.exercisesTableView.reloadData()
                
                self.updateUI()
            }
        }
        watcher.refetch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartSegue" {
            if let destinationVC = segue.destination as? StartViewController {
                destinationVC.routine = self.dbRoutine
            }
        }
    }
    
    @IBAction func saveRoutineButtonTapped(_ sender: UIButton) {
        var dbExercises: [ExerciseInput] = []
        var dbSets: [SetInput] = []
        for (i, ex) in dbRoutine!.exercises.enumerated() {
            for (j, _) in ex.sets.enumerated() {
                let cell = exercisesTableView.cellForRow(at: IndexPath(row: j, section: i)) as! ExerciseSetTableViewCell
                dbSets.append(SetInput.init(kg: Double(cell.amountKGTextField.text!)!, reps: Double(cell.amountRepsTextField.text!)!))
                
                dbRoutine!.exercises[i].sets[j].kg = Double(cell.amountKGTextField.text!)!
                dbRoutine!.exercises[i].sets[j].reps = Double(cell.amountRepsTextField.text!)!
            }
            dbExercises.append(ExerciseInput.init(name: ex.name, sets: dbSets))
            dbSets = []
        }
        
        routineNameLabel.text = newRoutineName
        dbRoutine!.name = newRoutineName!
        routineNameLabel.isHidden = false
        newNameTextField.isHidden = true
        
        networkManager.apollo.perform(mutation: UpdateRoutineMutation(input: RoutineInput.init(id: Double(dbRoutine!.id), name: newRoutineName!, exercises: dbExercises))) { result in
            guard let _ = try? result.get().data?.updateRoutine else {
                print("Server Error: Cannot get routine")
                return
            }
        }
    }
    
    @IBAction func newRoutineNameEditingDidChange(_ sender: UITextField) {
        newRoutineName = newNameTextField.text!
    }
    
    @IBAction func startRoutineButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "StartSegue", sender: nil)
    }
    
    func updateUI() {
        routineNameLabel.isHidden = false
        routineNameLabel.text = newRoutineName
        newNameTextField.isHidden = true
        newNameTextField.text = newRoutineName
        
        exercisesTableView.delegate = self
        exercisesTableView.dataSource = self
        
        
        // URL: https://stackoverflow.com/questions/33658521/how-to-make-a-uilabel-clickable
        let tap = UITapGestureRecognizer(target: self, action: #selector(EditViewController.tapFunction))
        routineNameLabel.isUserInteractionEnabled = true
        routineNameLabel.addGestureRecognizer(tap)
    }
    
    @IBAction func tapFunction(sender: UITapGestureRecognizer) {
        routineNameLabel.isHidden = true
        newNameTextField.isHidden = false
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
    
    // Make rows editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            dbRoutine!.exercises[indexPath.section].sets.remove(at: indexPath.row)
            
            exercisesTableView.beginUpdates()
            exercisesTableView.deleteRows(at: [indexPath], with: .automatic)
            
            if dbRoutine!.exercises[indexPath.section].sets.count == 0 {
                dbRoutine!.exercises.remove(at: indexPath.section)
                let indexSet = NSMutableIndexSet()
                indexSet.add(indexPath.section)
                exercisesTableView.deleteSections(indexSet as IndexSet, with: .automatic)
                
                if dbRoutine!.exercises.count == 0 {
                    dismiss(animated: true, completion: nil)
                }
            }
            
            exercisesTableView.endUpdates()
        }
    }

}
