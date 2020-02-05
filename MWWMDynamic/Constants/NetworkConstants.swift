//
//  NetworkConstants.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 20.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import UIKit

enum WeatherUnits {
    case imperial
    case metric
}

class NetworkConstants {
    
    static let baseUrl = "https://api.openweathermap.org/data/2.5/"
    static let appIdItem = URLQueryItem(name: "appId", value: "185c2af5465b32cb77984108d4136e82")
    
    struct Weather {
        static func currentWeather(lat: Float, lon: Float) -> String {
            var components = URLComponents(string: baseUrl + "weather")
            
            let latItem = URLQueryItem(name: "lat", value: String(lat))
            let lonItem = URLQueryItem(name: "lon", value: String(lon))
            
            if let unitChoice = UserDefaults.standard.string(forKey: UserDefaultsConstants.unitChoice) {
                let unitsItem = URLQueryItem(name: "units", value: unitChoice)
                components?.queryItems = [latItem, lonItem, appIdItem, unitsItem]
            } else {
                components?.queryItems = [latItem, lonItem, appIdItem]
            }
            
            if let urlString = components?.url?.absoluteString {
                return urlString
            } else {
                return ""
            }
        }
    }
    
    struct Group {
        static func multipleForecastWithId(cityIds:[String]) -> String {
            var components = URLComponents(string: baseUrl + "group")
            
            let cityIdList = cityIds.joined(separator:",")
            let citiesItem = URLQueryItem(name: "id", value: cityIdList)
            
            if let unitChoice = UserDefaults.standard.string(forKey: UserDefaultsConstants.unitChoice) {
                let unitsItem = URLQueryItem(name: "units", value: unitChoice)
                components?.queryItems = [citiesItem, appIdItem, unitsItem]
            } else {
                components?.queryItems = [citiesItem, appIdItem]
            }
            
            if let urlString = components?.url?.absoluteString {
                return urlString
            } else {
                return ""
            }
        }
    }
    
    struct FiveDayForecast {
        static func fiveDayForecast(cityId: String) -> String {
            var components = URLComponents(string: baseUrl + "forecast")
            
            let cityItem = URLQueryItem(name: "id", value: cityId)
            
            if let unitChoice = UserDefaults.standard.string(forKey: UserDefaultsConstants.unitChoice) {
                let unitsItem = URLQueryItem(name: "units", value: unitChoice)
                components?.queryItems = [cityItem, appIdItem, unitsItem]
            } else {
                components?.queryItems = [cityItem, appIdItem]
            }
            
            if let urlString = components?.url?.absoluteString {
                return urlString
            } else {
                return ""
            }
        }
    }
    
}
