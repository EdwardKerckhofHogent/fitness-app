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
    
    var testSets: [ExerciseSet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func insertNewSet() {
        testSets.append(ExerciseSet(kg: 0, reps: 0))
        let indexPath = IndexPath(row: testSets.count - 1, section: 0)
        setsTableView.beginUpdates()
        setsTableView.insertRows(at: [indexPath], with: .automatic)
        setsTableView.endUpdates()
    }
    
    @IBAction func addSetButtonTapped(_ sender: Any) {
        setsTableView.isHidden = false
        insertNewSet()
    }
    
    @IBAction func saveExerciseButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
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
        return testSets.count
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
            testSets.remove(at: indexPath.row)
            
            setsTableView.beginUpdates()
            setsTableView.deleteRows(at: [indexPath], with: .automatic)
            
            if testSets.count == 0 {
                setsTableView.isHidden = true
            }
            
            setsTableView.endUpdates()
        }
    }
}
