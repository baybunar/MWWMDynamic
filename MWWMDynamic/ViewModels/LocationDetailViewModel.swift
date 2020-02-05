//
//  LocationDetailViewModel.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 20.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import UIKit

protocol LocationDetailViewModelProtocol {
    var locationName: String? { get }
    var locationTemperature: String? { get }
}

class LocationDetailViewModel: LocationDetailViewModelProtocol {
    
    var locationName: String?
    var locationTemperature: String?    
    
    init(locationName: String, locationTemperature: String) {
        self.locationName = locationName
        self.locationTemperature = locationTemperature
    }

}
