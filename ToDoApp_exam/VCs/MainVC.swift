//
//  MainVC.swift
//  ToDoApp_exam
//
//  Created by Chingiz Jumanov on 26/10/22.
//

import UIKit
import Lottie
class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let animationView = LottieAnimationView()
    var newTasks: [TaskDM] = []
    var finishedTasks: [TaskDM] = []
    var archivedTasks: [TaskDM] = []
    var headers: [String] = ["New Tasks", "Finished Tasks", "Archived Tasks"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpAnimation()
    }
    

    
    func setUpAnimation() {
        animationView.animation = LottieAnimation.named("task")
        animationView.frame = UIScreen.main.bounds
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        UIView.animate(withDuration: 0.5, delay: 3) {
            self.animationView.alpha = 0
        }
        
        
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskTVC.nib(), forCellReuseIdentifier: TaskTVC.identifier)
        tableView.contentInset = .init(top: 30, left: 0, bottom: 50, right: 0)
    }
    
    
    @IBAction func plusTapped(_ sender: UIButton) {
        
        let vc = NewTaskVC(nibName: "NewTaskVC", bundle: nil)
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}

//MARK: - UITableViewDelegate
extension MainVC: UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        headers.count
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            if indexPath.section == 0 {
                //new
                self.newTasks.remove(at: indexPath.row)
            } else if indexPath.section == 1 {
                //finished
                self.finishedTasks.remove(at: indexPath.row)
            } else {
                //archived
                self.archivedTasks.remove(at: indexPath.row)
            }
            self.tableView.reloadData()
        }
        
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView(frame: .zero)
        v.backgroundColor = .clear
        
        let lbl = UILabel(frame: CGRect(x: self.view.frame.width/2-150/2, y: 0, width: 150, height: 30))
        v.addSubview(lbl)
        lbl.text = headers[section]
        lbl.backgroundColor = .systemGray6
        lbl.layer.cornerRadius = 15
        lbl.clipsToBounds = true
        lbl.font = .systemFont(ofSize: 17, weight: .semibold)
        lbl.textColor = .systemGreen
        lbl.textAlignment = .center
        
        if tableView.numberOfRows(inSection: section) == 0 {
            lbl.alpha = 0
        } else {
            lbl.alpha = 1
        }
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var choosenTask: TaskDM!
        if indexPath.section == 0 {
            //new tasks
            choosenTask = newTasks[indexPath.row]
        } else if indexPath.section == 1 {
            //finished
            choosenTask = finishedTasks[indexPath.row]
        } else {
            //archived
            choosenTask = archivedTasks[indexPath.row]
        }
        
        let alert = UIAlertController(title: "Choose what to do", message: nil, preferredStyle: .actionSheet)
        
        let finish = UIAlertAction(title: "Finish 🎉", style: .default) { (_) in
            // finish action
            choosenTask.place = .finished
            self.finishedTasks.append(choosenTask)
            self.newTasks.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        let archive = UIAlertAction(title: "Archive", style: .default) { (_) in
            //archive action
            choosenTask.place = .archived
            self.archivedTasks.append(choosenTask)
            if indexPath.section == 0 {
                self.newTasks.remove(at: indexPath.row)
            } else {
                self.finishedTasks.remove(at: indexPath.row)
            }
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let unarchive = UIAlertAction(title: "Unarchive", style: .default) { (_) in
            //Unarchive action
            choosenTask.place = .new
            self.newTasks.append(choosenTask)
            self.archivedTasks.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        let unfinish = UIAlertAction(title: "Unfinish ⬆️", style: .default) { (_) in
            //Unfinish action
            choosenTask.place = .new
            self.newTasks.append(choosenTask)
            self.finishedTasks.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        if indexPath.section == 0 {
            //new tasks
            alert.addAction(finish)
            alert.addAction(archive)
            
            let delete = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                //Delete action
                self.newTasks.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
            
            alert.addAction(delete)
            
        } else if indexPath.section == 1 {
            //finished
            alert.addAction(unfinish)
            alert.addAction(archive)
            
            let delete = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                //Delete action
                self.finishedTasks.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
            alert.addAction(delete)
        } else {
            //archived
            alert.addAction(unarchive)
            
            let delete = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                //Delete action
                self.archivedTasks.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
            alert.addAction(delete)
        }
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
//MARK: - UITableViewDataSource
extension MainVC: UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return newTasks.count
        } else if section == 1 {
            //Finished
            return finishedTasks.count
        } else {
            //Archived
            return archivedTasks.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTVC.identifier, for: indexPath) as? TaskTVC else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            //new tasks
            cell.updateCell(task: newTasks[indexPath.row])
        } else if indexPath.section == 1 {
            //finished
            cell.updateCell(task: finishedTasks[indexPath.row])
        } else {
            //archived
            cell.updateCell(task: archivedTasks[indexPath.row])
        }
        
        return cell
    }
    
    
    
}

//MARK: - NewTaskVCDelegate
extension MainVC: NewTaskVCDelegate {
    func setCell(task: TaskDM) {
        newTasks.append(task)
        tableView.reloadData()
    }
}
