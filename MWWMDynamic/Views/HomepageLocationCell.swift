//
//  HomepageLocationCell.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 27.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import UIKit

class HomepageLocationCell: UITableViewCell {
    
    @IBOutlet var locationNameLabel: UILabel!
    @IBOutlet var locationTemperatureLabel: UILabel!
    
    var locationCellViewModel: HomepageLocationCellViewModel? {
        didSet {
            locationNameLabel.text = locationCellViewModel?.locationText
            locationTemperatureLabel.text = locationCellViewModel?.locationTemperature
        }
    }
    
    override func prepareForReuse() {
        locationNameLabel.text = nil
        locationTemperatureLabel.text = nil
    }
}
