//
//  CreateRoutineViewController.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 14/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import UIKit

class CreateRoutineViewController: UIViewController {
    @IBOutlet var headerView: Header!
    @IBOutlet var introTextLabel: UILabel!
    @IBOutlet var saveRoutineButton: UIButton!
    @IBOutlet var routineNameTextField: UITextField!
    
    let networkManager = NetworkManager.shared
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        // Color word in string
        // URL: https://stackoverflow.com/questions/39665423/how-to-change-colour-of-the-certain-words-in-label-swift-3
        let introString = "Stel een nieuwe workout routine samen!"
        let colorWord = "workout"
        let range = (introString as NSString).range(of: colorWord)
        let attributedText = NSMutableAttributedString.init(string: introString)
        let customGreen = UIColor(red:0.16, green:0.56, blue:0.10, alpha:1.0)
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: customGreen, range: range)
        introTextLabel.attributedText = attributedText
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeSegue" {
            if let destinationVC = segue.destination as? HomeViewController {
                destinationVC.user = user!
            }
        }
    }
    
    
    @IBAction func saveRoutineButtonTapped(_ sender: UIButton) {
        guard let routineName = routineNameTextField.text else { return }
        
        networkManager.apollo.perform(mutation: AddRoutineMutation(input: RoutineInput.init(name: routineName))) { result in
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
}
