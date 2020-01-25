//
//  WeatherViewModel.swift
//  GoodWeather
//
//  Created by Alexander Smith on 1/24/20.
//  Copyright © 2020 Alexander Smith. All rights reserved.
//

import Foundation

class WeatherViewModel: ObservableObject {
  // API Service
  private var weatherService: WeatherService!
  
  // Weather Model | State Object
  @Published var weather = Weather()
  
  init() {
    // Initialize Network Service
    self.weatherService = WeatherService()
  }
  
  // .temperature | Computed
  var temperature: String {
    if let temp = self.weather.temp {
      return String(format: "%.0f", temp)
    } else {
      return ""
    }
  }
  
  // .humidity | Computed
  var humidity: String {
    if let humidity = self.weather.humidity {
      return String(format: "%.0f", humidity)
    } else {
      return ""
    }
  }
  
  // .cityName
  var cityName: String = ""
  
  // .search() | Parse and Search for City
  func search() {
    // Safe Guard for Name Spacing
    if let city = self.cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
      fetchWeather(by: city)
    }
  }
  
  // .fetchWeather(by: String) | Weather API Request
  private func fetchWeather(by city: String) {
    self.weatherService.getWeather(city: city) { weather in
      if let weather = weather {
        // ALWAYS! update ObservedObjects on the Main Thread with a Dispatch
        DispatchQueue.main.async {
          self.weather = weather
        }
      }
    }
  }
}
