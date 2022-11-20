//
//  NewTaskVC.swift
//  ToDoApp_exam
//
//  Created by Chingiz Jumanov on 26/10/22.
//

import UIKit

protocol NewTaskVCDelegate {
    func setCell(task: TaskDM)
}

class NewTaskVC: UIViewController {

    @IBOutlet weak var taskDescTv: UITextView!
    
    @IBOutlet weak var taskTitleTf: UITextField!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var priorityBtn: UIButton!
    
    var delegate: NewTaskVCDelegate?
    
    var priority: TaskPriority = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func PriorityTapped(_ sender: UIButton) {
        let vc = PriorityVC(nibName: "PriorityVC", bundle: nil)
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        
    }
    
    @IBAction func AddTapped(_ sender: Any) {
    
        if let title = taskTitleTf.text {
            if let desc = taskDescTv.text {
                if title.isEmpty {
                    let ok = UIAlertAction(title: "OK", style: .default)
                    let alertVC = UIAlertController(title: "Task title can not be empty", message: "Please write the task title in order to create a new task.", preferredStyle: .alert)
                    alertVC.addAction(ok)
                    self.present(alertVC, animated: true)
                } else {
                    let task = TaskDM(title: title, desc: desc, priority: priority)
                    delegate?.setCell(task: task)
                    self.dismiss(animated: true)
                }
            }
        }
        
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}




//MARK: -
extension NewTaskVC: PriorityVCDelegate {
    func setPriority(title: String, color: UIColor, priority: TaskPriority) {
        priorityBtn.setTitle(title, for: .normal)
        priorityBtn.backgroundColor = color
        self.priority = priority
    }
}
