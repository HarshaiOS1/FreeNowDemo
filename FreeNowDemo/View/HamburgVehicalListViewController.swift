//
//  HamburgVehicalListViewController.swift
//  FreeNowDemo
//
//  Created by wfh on 29/10/20.
//

import Foundation
import UIKit

class HamburgVehicalListViewController: ViewController {
    
    @IBOutlet weak var vehicalListTableView: UITableView!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var filterTypeLabel: UILabel!

    var arrFilterList = ["Active", "Inactive", "Nearest"]
    var isExpand : Bool?
    var currentlySelectedFilter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Vehicals in Hamburg Area"
        vehicalListTableView.delegate = self
        vehicalListTableView.dataSource = self
    }
    
    @IBAction func dropDownButtonAction(_ sender: Any) {
        isExpand = !(isExpand ?? false)
        DispatchQueue.main.async {
            self.vehicalListTableView.reloadSections(IndexSet(integer: 0), with: .bottom)
        }
    }
    
    deinit {
        print("deinit - HamburgVehicalListViewController")
    }
}

extension HamburgVehicalListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return isExpand ?? false ? arrFilterList.count : 0
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterOptionCell", for: indexPath)
            cell.textLabel?.text = arrFilterList[indexPath.row]
            cell.textLabel?.textColor = UIColor.white
            cell.backgroundColor = UIColor.lightGray
            return cell
        } else {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VehicalTableViewCell", for: indexPath) as? VehicalTableViewCell else {
            return UITableViewCell.init()
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            filterTypeLabel.text = "Filter: " + self.arrFilterList[indexPath.row].uppercased()
            isExpand = !(isExpand ?? false)
            currentlySelectedFilter = indexPath.row
//            viewModel.filterData(dropDownRow: indexPath.row)
            tableView.reloadData()
        } else { }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 40.0
        }
        return 70.0
    }
}
