//
//  ViewController.swift
//  FreeNowDemo
//
//  Created by wfh on 29/10/20.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var getVehicalListButton: UIButton! {
        didSet {
            getVehicalListButton.setTitle("Get Vehicals in Hamburg Area", for: .normal)
        }
    }
    
    @IBOutlet weak var getVehicalInMapButton: UIButton! {
        didSet {
            getVehicalInMapButton.setTitle("Get Vehicals near You", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome to Free Now!"
    }
    
    @IBAction func vehicalInfoButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    if (sender as! UIButton).tag == 0 {
        if let vc = storyboard.instantiateViewController(identifier: "HamburgVehicalListViewController") as? HamburgVehicalListViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        } else if (sender as! UIButton).tag == 1 {
            
        }
    }
    
    deinit {
        print("Deinit - ViewController")
    }
}
