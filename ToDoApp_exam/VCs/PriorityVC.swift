//
//  PriorityVC.swift
//  ToDoApp_exam
//
//  Created by Chingiz Jumanov on 26/10/22.
//

import UIKit
protocol PriorityVCDelegate {
    func setPriority(title: String, color: UIColor, priority: TaskPriority)
}


class PriorityVC: UIViewController {

    ///closure priority
//    var priorityTitle: (() -> (String))?
//    var priorityColor: (() -> (UIColor))?
    var delegate: PriorityVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func priorityTapped(_ sender: UIButton) {
        
        var priority: TaskPriority = .none
        
        switch sender.tag {
        case 0:
            priority = .high
        case 1:
            priority = .medium
        case 2:
            priority = .low
        case 3:
            priority = .none
        default:
            priority = .none
        }
        
        delegate?.setPriority(title: sender.currentTitle!, color: sender.backgroundColor!, priority: priority)
        self.dismiss(animated: true)
    }
        
        
}
    
