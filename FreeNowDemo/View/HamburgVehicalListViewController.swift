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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Vehicals in Hamburg Area"
        vehicalListTableView.delegate = self
        vehicalListTableView.dataSource = self
        vehicalListTableView.register(UINib.init(nibName: "VehicalTableViewCell", bundle: nil), forCellReuseIdentifier: "VehicalTableViewCell")
    }
    
    deinit {
        print("deinit - HamburgVehicalListViewController")
    }
}

extension HamburgVehicalListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VehicalTableViewCell", for: indexPath) as? VehicalTableViewCell else {
            return UITableViewCell.init()
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}
