//
//  ViewController.swift
//  TableViewSample
//
//  Created by Tomoki Hasegawa on 2020/10/05.
//  Copyright © 2020 Tomoki Hasegawa. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var labels = [
        "テスト1",
        "テスト2",
        "テスト3",
        "テスト4",
        "テスト5"
    ]
    var cellStatus = [
        0,
        0,
        0,
        0,
        0
    ]
    
    var changeState: ((Bool) -> Void)?

    @IBOutlet weak var tableView: UITableView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = false
        
        locationManager.delegate = self
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.isSelected = false
            let index = indexPath.item
            if cellStatus[index] == 0 {
                cellStatus[index] = 1
            } else {
                cellStatus[index] = 0
            }
            
            print("tap cell: \(indexPath.item), status: \(cellStatus[index] == 0 ? "shrink" : "expand")")
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("move from \(sourceIndexPath.item) to \(destinationIndexPath.item)")
        labels.insert(labels[sourceIndexPath.item], at: destinationIndexPath.item)
        labels.remove(at: sourceIndexPath.item)
        print("current: \(labels)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt -- index: \(indexPath.item)")
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell else {
            return UITableViewCell()
        }
        
        cell.label.text = labels[indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("heightForRawAt -- index: \(indexPath.item)/\(tableView.visibleCells.count)")
        if cellStatus[indexPath.item] == 1 {
            return 100
        }
        return 40
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("status: \(status.rawValue)")
        if CLLocationManager.authorizationStatus() == .notDetermined {
            manager.requestAlwaysAuthorization()
        }
    }
}

