//
//  ViewController.swift
//  Week4Assessment
//
//  Created by PraDeePKuMaR RaJaRaM on 20/09/23.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var taskCount: UILabel!
    @IBOutlet weak var listCollectionView: UICollectionView!
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    var listViewModel = ListViewModel()
    let alertControllerManager = AlertControllerManger.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumInteritemSpacing = 22
        listCollectionView.collectionViewLayout = layout
        listCollectionView.register(UINib(nibName: "Cell1CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell1")
        listCollectionView.register(HeaderCollectionReusableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        if listViewModel.totalTaskCount() == 0 {
            listCollectionView.isHidden = true
        }
        taskCount.text = "Tasks: \(listViewModel.totalTaskCount())"
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        listViewModel.listAPIRequest { isSuccess in
            self.activityIndicator.stopAnimating()
            if !isSuccess {
                self.alertControllerManager.showAlert(on: self, title: "Information", message: self.listViewModel.message)
            } else {
                self.listCollectionView.reloadData()
                if self.listViewModel.totalTaskCount() > 0 {
                    self.taskCount.text = "Task: \(self.listViewModel.totalTaskCount())"
                    self.listCollectionView.isHidden = false
                }
            }
        }
    }
    
    @IBAction func addTaskBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        self.view.window?.rootViewController = vc
        self.view.window?.makeKeyAndVisible()
    }
    
}

//MARK: - EXTENSION FOR COLLECTION

extension ListViewController: UICollectionViewDelegate {
    
}

extension ListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return listViewModel.taskAssigned.count
        }
        return listViewModel.taskCompleted.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! Cell1CollectionViewCell
        let taskAssignedImage = UIImage(named: "Assigned")!
        let taskCompletedImage = UIImage(named: "Completed")!
        if indexPath.section == 0 {
            cell1.delegate = self
            cell1.update(listViewModel.taskAssigned[indexPath.row], statusImage: taskAssignedImage)
        } else if indexPath.section == 1 {
            cell1.update(listViewModel.taskCompleted[indexPath.row], statusImage: taskCompletedImage)
        }
        return cell1
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 60 - 22) / 2
        return CGSize(width: cellWidth, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as? HeaderCollectionReusableView else { return UICollectionReusableView() }
        header.configure(with: "")
        if (indexPath.section == 0) && (!listViewModel.taskAssigned.isEmpty )  {
            header.configure(with: listViewModel.sectionNameArray[indexPath.section])
        } else if (indexPath.section == 1) && (!listViewModel.taskCompleted.isEmpty) {
            header.configure(with: listViewModel.sectionNameArray[indexPath.section])
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 45.0)
    }
}

//MARK: - Fetching data

extension ListViewController: PassListDataDelegate {
    func passData(taskTitle: String,taskDesc: String) {
        //        listViewModel.didAddTask(Info)
        activityIndicator.startAnimating()
        listViewModel.addListAPIRequest(parameters: ["name": taskTitle,"description":taskDesc]) { isSuccess in
            self.activityIndicator.stopAnimating()
            if isSuccess {
                self.listCollectionView.isHidden = false
                self.taskCount.text = "Task: \(self.listViewModel.totalTaskCount())"
                self.listCollectionView.reloadData()
            } else {
                self.alertControllerManager.showAlert(on: self, title: "Information", message: self.listViewModel.message)
            }
        }
    }
}

extension ListViewController: UpdatedDataDelegate {
    func updated(_ info: Int ) {
        activityIndicator.startAnimating()
        listViewModel.completedListAPIRequest(id: info) { isSuccess in
            self.activityIndicator.stopAnimating()
            if isSuccess {
                self.listViewModel.taskAssigned = self.listViewModel.taskAssigned.filter{ task in
                    return task.id != info
                }
                self.taskCount.text = "Tasks: \(self.listViewModel.totalTaskCount())"
                self.listCollectionView.reloadData()
            } else {
                self.alertControllerManager.showAlert(on: self, title: "Information", message: self.listViewModel.message)
            }
        }
        
        
        
    }
}
