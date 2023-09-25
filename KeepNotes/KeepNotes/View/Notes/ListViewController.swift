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
    
    var index: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MyTask"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        self.navigationItem.leftBarButtonItem?.tintColor = .purple
        listTableView.register(UINib(nibName: "Cell1TableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
        listTableView.register(UINib(nibName: "Cell2TableViewCell", bundle: nil), forCellReuseIdentifier: "cell2")
        listTableView.register(UINib(nibName: "SectionTableViewHeader", bundle: nil), forCellReuseIdentifier: "header")
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.separatorColor = UIColor.clear
        let sumCount = userData[index].taskAssigned.count + userData[index].taskCompleted.count
        if sumCount == 0 {
            listTableView.isHidden = true       // hidding the table initally
        }
        
        taskCount.text = "Task: \(sumCount)"
    }
    
    @IBAction func addTaskBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main2", bundle: nil).instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func logout() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNav")
        self.view.window?.rootViewController = vc
        self.view.window?.makeKeyAndVisible()
    }
    
    func setEmailAndFindIndex(_ email:String) {
        index = userData.firstIndex { data in
            data.email == email
        } ?? -1
    }
}

//MARK: - EXTENSION FOR TABLE

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

extension ListViewController: UITableViewDataSource {
//MARK: - SECTION
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sections = tableView.dequeueReusableCell(withIdentifier: "header") as! SectionTableViewHeader
                if section == 0 {
                    userData[index].taskAssigned.isEmpty ? nil : sections.update(sectionNameArray[section])
                } else if section == 1 {
                    userData[index].taskCompleted.isEmpty ? nil : sections.update(sectionNameArray[section])
                }
        return sections
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNameArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return userData[index].taskAssigned.count
        }
        return userData[index].taskCompleted.count
    }
//MARK: - CELL INIT
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1") as! Cell1TableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2") as! Cell2TableViewCell
        if indexPath.section == 0 {
            cell1.delegate = self
            cell1.update(userData[index].taskAssigned[indexPath.row])
            return cell1
        } else if indexPath.section == 1{
            cell2.update(userData[index].taskCompleted[indexPath.row])
            return cell2
        }
        return cell1
    }
//MARK: - CELL DELETION ACTION FOR COMPLETED TASK
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 1{
                userData[index].taskCompleted.remove(at: indexPath.row)
                listTableView.deleteRows(at: [indexPath], with: .fade)
                taskCount.text = "Task: \(userData[index].taskAssigned.count+userData[index].taskCompleted.count)"
                listTableView.reloadData()
            } else if indexPath.section == 0 {
                userData[index].taskAssigned.remove(at: indexPath.row)
                listTableView.deleteRows(at: [indexPath], with: .fade)
                taskCount.text = "Task: \(userData[index].taskAssigned.count+userData[index].taskCompleted.count)"
                listTableView.reloadData()
            }
                
        }
    }
}

//MARK: - Fetching data
extension ListViewController: PassListDataDelegate {    
    func passData(_ Info: Task) {
        userData[index].taskAssigned.append(Info)
        taskCount.text = "Task: \(userData[index].taskAssigned.count+userData[index].taskCompleted.count)"
        listTableView.isHidden = false
        listTableView.reloadData()
    }
}

extension ListViewController: UpdatedDataDelegate {
    func updated(_ info: UITableViewCell ) {
        let index = listTableView.indexPath(for: info)
        if let row = index?.row {
            userData[self.index].taskCompleted.insert(userData[self.index].taskAssigned[row], at: 0)
            userData[self.index].taskAssigned.remove(at: row)
            listTableView.reloadData()
        }
    }
}
