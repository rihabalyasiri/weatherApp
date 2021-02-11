//
//  WeatherData.swift
//  Clima
//
//  Created by Rihab Al-yasiri on 10.02.21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

// should be same structure and names that came from Json API

struct WeatherData: Codable {
    let name : String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}
