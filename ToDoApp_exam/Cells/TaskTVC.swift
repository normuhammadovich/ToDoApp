//
//  TaskTVC.swift
//  ToDoApp_exam
//
//  Created by Chingiz Jumanov on 26/10/22.
//

import UIKit

class TaskTVC: UITableViewCell {

    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var priorityView: UIView!
    
    static func nib() -> UINib {
        UINib(nibName: "TaskTVC", bundle: nil)
    }
    static let identifier = "TaskTVC"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }
    
    
    func updateCell(task: TaskDM) {
        titleLbl.text = task.title
        descLbl.text = task.desc
        
        var color = UIColor.white
        
        switch task.priority {
        case .none:
            color = .clear
        case .low:
            color = .green
        case .medium:
            color = .yellow
        case .high:
            color = .red
        }
        priorityView.backgroundColor = color
        
    }

   
    
}
