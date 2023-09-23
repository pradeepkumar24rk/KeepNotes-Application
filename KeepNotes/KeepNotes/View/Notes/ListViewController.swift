//
//  ViewController.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 20/09/23.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var taskCount: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    
    var email = String()
    let index = userData.firstIndex { data in
        data.email == email
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MyTask"
        listTableView.register(UINib(nibName: "Cell1TableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
        listTableView.register(UINib(nibName: "Cell2TableViewCell", bundle: nil), forCellReuseIdentifier: "cell2")
        listTableView.register(UINib(nibName: "SectionTableViewHeader", bundle: nil), forCellReuseIdentifier: "header")
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.separatorColor = UIColor.clear
        listTableView.isHidden = true
        taskCount.text = "Task: \(taskAssigned.count+taskCompleted.count)"
    }
    
    @IBAction func addTaskBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main2", bundle: nil).instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - EXTENSION FOR TABLE

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sections = tableView.dequeueReusableCell(withIdentifier: "header") as! SectionTableViewHeader
                if section == 0 {
                    taskAssigned.isEmpty ? nil : sections.update(sectionNameArray[section])
                } else if section == 1 {
                    taskCompleted.isEmpty ? nil : sections.update(sectionNameArray[section])
                }
        return sections
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNameArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return taskAssigned.count
        }
        return taskCompleted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1") as! Cell1TableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2") as! Cell2TableViewCell
        if indexPath.section == 0 {
            cell1.delegate = self
            cell1.update(taskAssigned[indexPath.row])
            return cell1
        } else if indexPath.section == 1{
            cell2.update(taskCompleted[indexPath.row])
            return cell2
        }
        return cell1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 1{
                taskCompleted.remove(at: indexPath.row)
                listTableView.deleteRows(at: [indexPath], with: .fade)
                taskCount.text = "Task: \(taskAssigned.count+taskCompleted.count)"
                listTableView.reloadData()
            } else if indexPath.section == 0 {
                taskAssigned.remove(at: indexPath.row)
                listTableView.deleteRows(at: [indexPath], with: .fade)
                taskCount.text = "Task: \(taskAssigned.count+taskCompleted.count)"
                listTableView.reloadData()
            }
                
        }
    }
}

//MARK: - Fetching data

extension ListViewController: PassListDataDelegate {    
    func passData(_ Info: Task) {
        taskAssigned.append(Info)
        taskCount.text = "Task: \(taskAssigned.count+taskCompleted.count)"
        listTableView.isHidden = false
        listTableView.reloadData()
    }
}

extension ListViewController: UpdatedDataDelegate {
    func updated(_ info: UITableViewCell ) {
        let index = listTableView.indexPath(for: info)
        if let row = index?.row {
            taskCompleted.insert(taskAssigned[row], at: 0)
            taskAssigned.remove(at: row)
            listTableView.reloadData()
        }
    }
}
