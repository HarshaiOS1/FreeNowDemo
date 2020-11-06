//
//  VehicalTableViewCell.swift
//  FreeNowDemo
//
//  Created by Harsha K on 29/10/20.
//

import Foundation
import UIKit
class VehicalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carTypeLabel: UILabel!
    @IBOutlet weak var carAvailabilityLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func updateUI() {
        self.contentView.backgroundColor = UIColor.lightText
    }
}
