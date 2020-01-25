//
//  WeatherService.swift
//  GoodWeather
//
//  Created by Alexander Smith on 1/24/20.
//  Copyright © 2020 Alexander Smith. All rights reserved.
//

import Foundation

class WeatherService {
  
  // WeatherService.getWeather(city: String)
  func getWeather(city: String, completion: @escaping (Weather?) -> ()) {
    // Format API URL Endpoint
    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=f5572e969a8a2eb6135ea3c79f3783c3&units=imperial") else {
      completion(nil)
      return
    }
    
    // Create URLSession with URL and return JSON Response if Successful
    URLSession.shared.dataTask(with: url) { data, response, error in
      // Check for Data and Error
      guard let data = data, error == nil else {
        completion(nil)
        return
      }
      // Parse & Return JSON Data
      let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
      if let weatherResponse = weatherResponse {
        let weather = weatherResponse.main
        completion(weather)
      } else {
        completion(nil)
      }
    }.resume()
  }
  
}
