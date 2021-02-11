//
//  WeatherManager.swift
//  Clima
//
//  Created by Rihab Al-yasiri on 09.02.21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

// it is convention in Swift Community to define Protocol in same File where it would be used
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid={API_KEY}&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString)
    }
    
    func fetchWeather( latitude: CLLocationDegrees, longtitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longtitude)"
        performRequest(urlString)
    }
    
    // _ --> external Parameter used when func called, urlString --> internal Parameter used when func define
    func performRequest(_ urlString: String) {
        // 1. create a URL
        if let url = URL(string: urlString) {
            
            // 2. create a URLSession --> that perform Networking
            let session = URLSession(configuration: .default)
            
            // 3. give the session a task
            let task = session.dataTask(with: url, completionHandler: handle(data:responce:error:))
            
            // 4. start the task
            task.resume()
        }
       
    }
    
    func handle(data: Data?, responce: URLResponse?, error: Error?) -> Void {
        if error != nil {
            // itcould be fail cuz of lost Internet
            delegate?.didFailWithError(error as! Error)
            return
        }
        if let safeData = data {
           //parse data from Json to Swift Object
            if let weather =  parseJSON(weatherData: safeData) {
                delegate?.didUpdateWeather(self, weather: weather)
            }
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
          
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            // here will update the WeatherModel with the data that came from the API
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
          
        }catch {
            // it could be fail if the data not decoded
            delegate?.didFailWithError(error)
            return nil
        }
        
    }
    

}
