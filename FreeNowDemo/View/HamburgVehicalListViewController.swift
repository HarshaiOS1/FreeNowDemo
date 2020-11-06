//
//  HamburgVehicalListViewController.swift
//  FreeNowDemo
//
//  Created by Harsha K on 29/10/20.
//

import Foundation
import UIKit

class HamburgVehicalListViewController: ViewController {
    
    @IBOutlet weak var vehicalListTableView: UITableView!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var filterTypeLabel: UILabel!
    
    private var arrFilterList = ["None","Active", "Inactive", "Nearest"]
    private var vehicalListViewModel : VehicalListViewModel!
    var tempPoiList : [PoiList]?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var isExpand : Bool?
    var currentlySelectedFilter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        self.title = "Vehicals in Hamburg Area"
        vehicalListTableView.delegate = self
        vehicalListTableView.dataSource = self
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func updateUI() {
        self.vehicalListViewModel = VehicalListViewModel()
        vehicalListViewModel.getVehicalListInHamburgArea { (didGetDetails, error) in
            if didGetDetails {
                print("Loading Table")
            } else {
                print(error ?? "Error loading table")
            }
        }
        self.vehicalListViewModel.modelObserver = {
            DispatchQueue.main.async {
                self.tempPoiList = self.vehicalListViewModel.vehicalListModel.poiList
                self.activityIndicator.removeFromSuperview()
                self.vehicalListTableView.reloadData()
            }
        }
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

//MARK: TableView Delegate and DataSource Methods
extension HamburgVehicalListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return isExpand ?? false ? arrFilterList.count : 0
        }
        if let count = tempPoiList?.count, count > 0 {
            return count
        } else {
            return 1
        }
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
            if let dataArray = tempPoiList, dataArray.count > 0 {
                cell.textLabel?.isHidden = true
                cell.carTypeLabel.text = dataArray[indexPath.row].type?.rawValue
                cell.carAvailabilityLabel.text = dataArray[indexPath.row].state?.rawValue
                cell.distanceLabel.text = String(format: "%.2f", dataArray[indexPath.row].heading ?? -9999)
            } else {
                cell.textLabel?.isHidden = false
                cell.carTypeLabel.text = ""
                cell.carAvailabilityLabel.text = ""
                cell.distanceLabel.text = ""
                cell.textLabel?.text = "No results found, please change filter!"
            }
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            filterTypeLabel.text = "Filter : " + self.arrFilterList[indexPath.row].uppercased()
            isExpand = !(isExpand ?? false)
            currentlySelectedFilter = indexPath.row
            tempPoiList = vehicalListViewModel.filterData(dropDownRow: indexPath.row)
            vehicalListTableView.reloadData()
        } else { }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 40.0
        }
        return 70.0
    }
}
