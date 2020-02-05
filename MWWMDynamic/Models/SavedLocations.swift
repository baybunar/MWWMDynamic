//
//  SavedLocations.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 20.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import UIKit
import SwiftyJSON

class SavedLocations {
    
    var count: Int!
    var savedLocationList = [CurrentWeather]()
    
    required init(json: JSON) {
        count = json["cnt"].intValue
        for item in json["list"].arrayValue {
            let savedLocation = CurrentWeather(json: item)
            savedLocationList.append(savedLocation)
        }
        
    }
}
