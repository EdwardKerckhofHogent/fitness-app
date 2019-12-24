//
//  StartViewController.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 24/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet var routineNameLabel: UILabel!
    @IBOutlet var exerciseTableView: UITableView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var pauseButton: UIButton!
    @IBOutlet var stopRoutineButton: UIButton!
    @IBOutlet var timerLabel: UILabel!
    
    var routine: Routine?
    
    var timer: Timer?
    var counter: Int = 0
    var seconds: Int = 0
    var minutes: Int = 0
    var hours: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @objc func prozessTimer() {
        counter += 1
        seconds += 1
        
        // minute
        if isMultipleOf60(number: counter) {
            minutes += 1
            seconds = 0
            
            // hour
            if isMultipleOf60(number: minutes) {
                hours += 1
                minutes = 0
            }
        }
        
        if minutes < 10 && seconds < 10 {
            timerLabel.text = "0\(hours):0\(minutes):0\(seconds)"
        } else if minutes < 10 && seconds > 9 {
            timerLabel.text = "0\(hours):0\(minutes):\(seconds)"
        } else if minutes > 9 && seconds < 10 {
            timerLabel.text = "0\(hours):\(minutes):0\(seconds)"
        } else {
            timerLabel.text = "0\(hours):\(minutes):\(seconds)"
        }

    }
    
    @IBAction func toggleTimer(_ sender: UIButton) {
        if sender.self == pauseButton {
            // Toggle start/pause buttons
            toggleButtons(pauseIsHidden: true)
            
            // Show stop button
            stopRoutineButton.isHidden = false
            
            // Pause timer
            timer!.invalidate()
        } else if sender.self == startButton {
            // Start timer
            timer = Timer.scheduledTimer(timeInterval:1, target:self, selector:#selector(prozessTimer), userInfo: nil, repeats: true)
            
            // Toggle start/pause buttons
            toggleButtons(pauseIsHidden: false)
            
            // Hide stop button
            stopRoutineButton.isHidden = true
        }
    }
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        timer = nil
        performSegue(withIdentifier: "HomeSegue", sender: nil)
    }
    
    func updateUI() {
        // Label and table
        routineNameLabel.text = routine!.name
        exerciseTableView.delegate = self
        exerciseTableView.dataSource = self
        exerciseTableView.reloadData()
        
        // Start/pause button
        toggleButtons(pauseIsHidden: true)
    }
    
    func toggleButtons(pauseIsHidden: Bool) {
        pauseButton.isHidden = pauseIsHidden
        startButton.isHidden = !pauseButton.isHidden
    }
    
    func isMultipleOf60(number: Int) -> Bool {
        if number % 60 == 0 {
            return true
        } else {
            return false
        }
    }
}

extension StartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routine!.exercises[section].sets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = exerciseTableView.dequeueReusableCell(withIdentifier: "ExerciseSetCell") as! ExerciseSetTableViewCell
        
        cell.cellTitle.text = "Set: \(indexPath.row + 1)"
        
        var sets: [ExerciseSet] = []
        
        for set in routine!.exercises[indexPath.section].sets {
            sets.append(ExerciseSet(kg: set.kg, reps: set.reps))
        }
        
        cell.amountKGTextField.text = "\(sets[indexPath.row].kg)"
        cell.amountRepsTextField.text = "\(sets[indexPath.row].reps)"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return routine?.exercises.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = routine!.exercises[section].name
        label.font = UIFont(name: "Montserrat", size: 18)
        label.backgroundColor = UIColor.white
        label.textColor = UIColor(red:0.16, green:0.56, blue:0.10, alpha:1.0)
        return label
    }

}

