//
//  AddLocationViewModel.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 20.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import UIKit
import MapKit
import CoreData

protocol AddLocationViewModelProtocol {
    var pinnedLocation: CurrentWeather? { get }
    
    func getPinnedLocation(locationOnMap: CLLocationCoordinate2D?, completion: @escaping (Bool) -> ())
    func getAddLocationAlert() -> UIAlertController
}

class AddLocationViewModel: AddLocationViewModelProtocol {
    var pinnedLocation: CurrentWeather?        
    
    func getPinnedLocation(locationOnMap: CLLocationCoordinate2D?, completion: @escaping (Bool) -> ()) {
        if let locationOnMap = locationOnMap {
            NetworkService.shared.callService(request: Request(url: NetworkConstants.Weather.currentWeather(lat: Float(locationOnMap.latitude), lon: Float(locationOnMap.longitude)), method: .get)) { (response, error) in
                if let response = response, response.result, let jsonResult = response.json {
                    self.pinnedLocation = CurrentWeather(json: jsonResult)
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    func getAddLocationAlert() -> UIAlertController {
        let alertController = UIAlertController(title: "Save Location", message: "Do you want to add the location on bookmarks?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let managedContext = CoreDataService.shared.getManagedContext(), let entity = NSEntityDescription.entity(forEntityName: "Location", in: managedContext), let locationName = self.pinnedLocation?.name,
                    let cityId = self.pinnedLocation?.cityId,
                    let latitude = self.pinnedLocation?.coordinates?.lat,
                    let longitude = self.pinnedLocation?.coordinates?.lon {
                    let location = NSManagedObject(entity: entity, insertInto: managedContext) as? Location
                    location?.name = locationName
                    location?.cityId = String(cityId)
                    location?.latitude = Double(latitude)
                    location?.longitude = Double(longitude)
                
                    do {
                        try managedContext.save()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        return alertController
    }
}
