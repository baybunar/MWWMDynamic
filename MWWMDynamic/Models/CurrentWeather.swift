//
//  CurrentWeather.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 13.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import SwiftyJSON

class FiveDaysWeather {
    
    var list = [CurrentWeather]()
    
    init() {}
    
    required init(json: JSON) {
        for item in json["list"].arrayValue {
            let fiveDayInfo = CurrentWeather(json: item)
            list.append(fiveDayInfo)
        }
    }
}

class CurrentWeather {
    
    var name: String?
    var mainWeather: MainWeather?
    var cityId: Int?
    var coordinates: Coordinate?
    var wind: CurrentWind?
    var weather: CurrentWeatherInfo?
    var clouds: CloudInfo?
    var date: String?
    
    init() {}
    
    required init(json: JSON) {
        name = json["name"].stringValue
        mainWeather = MainWeather(json: json["main"])
        cityId = json["id"].intValue
        coordinates = Coordinate(json: json["coord"])
        wind = CurrentWind(json: json["wind"])
        weather = CurrentWeatherInfo(json: json["weather"])
        clouds = CloudInfo(json: json["clouds"])
        date = json["dt_txt"].stringValue
    }
}

class MainWeather {
    
    var temp: Float?
    var tempMin: Float?
    var tempMax: Float?
    var humidity: Float?
    
    init() {}
    
    required init(json: JSON) {
        temp = json["temp"].floatValue
        tempMin = json["temp_min"].floatValue
        tempMax = json["temp_max"].floatValue
        humidity = json["humidity"].floatValue
    }
}

class Coordinate {
    var lon: Float?
    var lat: Float?
    
    init() {}
    
    required init(json: JSON) {
        lon = json["lon"].floatValue
        lat = json["lat"].floatValue
    }
}

class CurrentWind {
    
    var speed: Float?
    
    init() {}
    
    required init(json: JSON) {
        speed = json["speed"].floatValue
    }
}

class CurrentWeatherInfo {
    
    var main: String?
    var description: String?
    var icon: String?
    
    init() {}
    
    required init(json: JSON) {
        main = json["main"].stringValue
        description = json["description"].stringValue
        icon = json["icon"].stringValue
    }
}

class CloudInfo {
    
    var all: Float?
    
    init() {}
    
    required init(json: JSON) {
        all = json["all"].floatValue
    }
}
