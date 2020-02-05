//
//  HomepageViewModel.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 13.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

protocol HomepageViewModelProtocol {
    var currentLocationText: String? { get }
    var currentLocationTemperature: String? { get }
    var selectedLocation: HomepageLocationCellViewModel? { get }    
    
    func getCurrentLocationWeather(lon: Float, lat: Float)
    func getLocallySavedLocations()
    func setSelectedLocation(at: IndexPath)
}

class HomepageViewModel: HomepageViewModelProtocol {
    
    var filteredSavedLocations: [CurrentWeather]?
    var currentWeather: CurrentWeather?
    var currentLocationText: String?
    var currentLocationTemperature: String?
    
    var savedLocationViewModels: [HomepageLocationCellViewModel]? {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var reloadTableViewClosure: (()->())?
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    var updateLoadingStatus: (()->())?
    
    var selectedLocation: HomepageLocationCellViewModel? {
        didSet {
            self.navigateToDetail?()
        }
    }
    var navigateToDetail: (()->())?
    
    func getCurrentLocationWeather(lon: Float, lat: Float) {
        self.isLoading = true
        NetworkService.shared.callService(request: Request(url: NetworkConstants.Weather.currentWeather(lat: lat, lon: lon), method: .get)) { (response, error) in
            if let response = response, response.result, let jsonResult = response.json {
                self.currentWeather = CurrentWeather(json: jsonResult)
                if let cityName = self.currentWeather?.name, let temperature = self.currentWeather?.mainWeather?.temp {
                    self.currentLocationText = cityName
                    self.currentLocationTemperature = String(describing: temperature)
                    self.isLoading = false
                }
            }
        }
    }
    
    func getLocallySavedLocations() {
        do {
            if let locationList = try CoreDataService.shared.fetchArray(entityName: "Location") {
                let locationIdArray = locationList.compactMap{ ($0 as! Location).cityId }
                if locationIdArray.count > 0 {
                    NetworkService.shared.callService(request: Request(url: NetworkConstants.Group.multipleForecastWithId(cityIds: locationIdArray), method: .get)) { (response, error) in
                        if let response = response, response.result, let jsonResult = response.json {
                            let savedLocations = SavedLocations(json: jsonResult).savedLocationList
                            self.savedLocationViewModels = savedLocations.compactMap { location -> HomepageLocationCellViewModel?  in
                                if let locationName = location.name, let temperature = location.mainWeather?.temp {
                                    return HomepageLocationCellViewModel(locationText: locationName, locationTemperature: String(describing: temperature))
                                } else {
                                    return nil
                                }
                            }
                        }
                    }
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func setSelectedLocation(at: IndexPath) {
        self.selectedLocation = self.savedLocationViewModels?[at.row]
    }

}
