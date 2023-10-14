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
    
    var listViewModel = ListViewModel()
    var indexOfUser:Int = -1           // getting the user index value for the auth view controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumInteritemSpacing = 22
        listCollectionView.collectionViewLayout = layout
        listCollectionView.register(UINib(nibName: "Cell1CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell1")
        listCollectionView.register(HeaderCollectionReusableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
        listViewModel.userIndex = indexOfUser    // assign user of the index to viewModel object
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        if listViewModel.totalTaskCount() == 0 {
            listCollectionView.isHidden = true       // hidding the table initally
        }
        taskCount.text = "Tasks: \(listViewModel.totalTaskCount())"
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func addTaskBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - EXTENSION FOR TABLE

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
    func passData(_ Info: Task) {
        listViewModel.didAddTask(Info)
        listCollectionView.isHidden = false
        taskCount.text = "Task: \(listViewModel.totalTaskCount())"
        listCollectionView.reloadData()
    }
}

extension ListViewController: UpdatedDataDelegate {
    func updated(_ info: UICollectionViewCell ) {
        let index = listCollectionView.indexPath(for: info)
        if index?.section == 0 {
            if let row = index?.row {
                listViewModel.didUpdateTask(row)
                taskCount.text = "Tasks: \(listViewModel.totalTaskCount())"
                listCollectionView.reloadData()
            }
        }
    }
}
