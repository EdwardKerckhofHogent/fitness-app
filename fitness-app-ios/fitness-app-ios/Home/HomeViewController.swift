//
//  HomeViewController.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 08/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var headerView: Header!
    @IBOutlet var routinesButton: UIButton!
    @IBOutlet var routinesTableView: UITableView!
    @IBOutlet var introTextLabel: UILabel!
    
    let networkManager = NetworkManager.shared
    var accessToken: String = ""
    var user: User?
    
    lazy var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colorWord = "menu"
        let customGreen = UIColor(red:0.16, green:0.56, blue:0.10, alpha:1.0)
        
        // Color word in string
        // URL: https://stackoverflow.com/questions/39665423/how-to-change-colour-of-the-certain-words-in-label-swift-3
        let introString = "What's on the menu today?"
        let range = (introString as NSString).range(of: colorWord)
        let attributedText = NSMutableAttributedString.init(string: introString)
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: customGreen, range: range)
        introTextLabel.attributedText = attributedText
        
        // Set background image to right
        // URL: https://stackoverflow.com/questions/7100976/how-do-i-put-the-image-on-the-right-side-of-the-text-in-a-uibutton
        routinesButton.semanticContentAttribute = UIApplication.shared
        .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        
        let watcher = networkManager.apollo.watch(query: MeQuery()) { result in
            guard let data = try? result.get().data?.me else {
                print("Server Error: Cannot get me")
                return
            }
            if (data.errors?[0] != nil) {
                print(data.errors![0].message)
            } else {
                var userRoutines: [Routine] = []
                var routineExercises: [Exercise] = []
                var exerciseSets: [ExerciseSet] = []
                
                for routine in data.user!.routines ?? [] {
                    for exercise in routine.exercises ?? [] {
                        for set in exercise.sets ?? [] {
                            exerciseSets.append(ExerciseSet(kg: set.kg, reps: set.reps))
                        }
                        routineExercises.append(Exercise(name: exercise.name, sets: exerciseSets))
                    }
                    userRoutines.append(Routine(id: routine.id, name: routine.name, exercises: routineExercises))
                }
                
                self.user = User(id: data.user!.id, email: data.user!.email, routines: userRoutines)
                self.networkManager.loggedInUser = self.user
                self.updateUI()
                self.routinesTableView.reloadData()
            }
        }
        watcher.refetch()
        print("Called")
    }
    
    @IBAction func routinesButtonTapped(_ sender: Any) {
        routinesTableView.isHidden = !routinesTableView.isHidden
    }
    
    func updateUI() {
        headerView.welcomeText.isHidden = false
        headerView.welcomeName.text = self.user!.nickname.capitalizeFirstLetter() + "!"
        headerView.logoutButton.isHidden = false
        headerView.logoutButton.addTarget(self, action: #selector (self.logoutButtonTapped), for: .touchUpInside)
        
        routinesTableView.isHidden = true
        routinesTableView.delegate = self
        routinesTableView.dataSource = self
    }
    
    @objc func logoutButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "LogoutSegue", sender: nil)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user!.routines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = routinesTableView.dequeueReusableCell(withIdentifier: "RoutineCell") as! HomeRoutineTableViewCell
        cell.setRoutineName(name: user!.routines[indexPath.row].name)
        return cell
    }
    
    // Make rows editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let routine = user!.routines[indexPath.row]
            
            user!.routines.remove(at: indexPath.row)
            
            routinesTableView.beginUpdates()
            routinesTableView.deleteRows(at: [indexPath], with: .automatic)
            
            if user!.routines.count == 0 {
                routinesTableView.isHidden = true
            }
            
            routinesTableView.endUpdates()
            
            // Delete routine from db
            networkManager.apollo.perform(mutation: DeleteRoutineMutation(input: Double(routine.id))) { result in
                guard let _ = try? result.get().data?.deleteRoutine else {
                    print("Server Error: Cannot delete routine")
                    return
                }
            }
        }
    }
}
