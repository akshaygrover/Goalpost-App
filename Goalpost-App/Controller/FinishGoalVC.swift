//
//  FinishGoalVC.swift
//  Goalpost-App
//
//  Created by akshay Grover on 2017-08-16.
//  Copyright © 2017 akshay Grover. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointsTextField.delegate = self
    }

    @IBAction func createGoalTapped(_ sender: UIButton) {
        if pointsTextField.text != "" {
        self.save { (compelete) in
            if compelete {
                dismiss(animated: true, completion: nil)
            }
        }
    }
}
    @IBAction func backBtnTapped(_ sender: UIButton) {
        dismissDetail()
    }
    func initData(description: String,type: GoalType) {
        self.goalDescription = description
        self.goalType = type
        
    }
    func save(completion: (_ finish: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        do{
            try managedContext.save()
            completion(true)
            print("sucess")
        } catch {
            debugPrint("error : \(error.localizedDescription)")
            completion(false)
        }
    }  
}
