//
//  LocationDetailViewController.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 20.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import UIKit

class LocationDetailViewController: UIViewController {
    
    @IBOutlet var locationNameLabel: UILabel!
    @IBOutlet var locationTemperatureLabel: UILabel!
    
    /*lazy var locationDetailViewModel: LocationDetailViewModel = {
        return LocationDetailViewModel()
    }()*/
    
    var locationDetailViewModel: LocationDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationNameLabel.text = locationDetailViewModel?.locationName
        locationTemperatureLabel.text = locationDetailViewModel?.locationTemperature
    }
    
}
