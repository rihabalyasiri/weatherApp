//
//  WeatherModel.swift
//  Clima
//
//  Created by Rihab Al-yasiri on 11.02.21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f",temperature)
    }
    
    //computed Property (should always be var and return (getter)) --> use it when I wanna create function just to get its value like Getter in Java
    var conditionName: String {
        switch conditionId {
            case 200...232:
                return "wind"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "smoke"
            case 800:
                return "sun.max"
            case 801...804:
                return "snow"
            default:
                return "cloud"
        }
    }
    

}
