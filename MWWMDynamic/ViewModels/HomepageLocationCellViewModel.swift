//
//  HomepageLocationCellViewModel.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 27.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import UIKit

protocol HomepageLocationCellProtocol {
    
    var locationText: String { get }
    var locationTemperature: String { get }
}

class HomepageLocationCellViewModel: HomepageLocationCellProtocol {
    
    var locationText: String
    var locationTemperature: String
    
    init(locationText: String, locationTemperature: String) {
        self.locationText = locationText
        self.locationTemperature = locationTemperature
    }

}
