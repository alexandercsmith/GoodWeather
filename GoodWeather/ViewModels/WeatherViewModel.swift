//
//  WeatherViewModel.swift
//  GoodWeather
//
//  Created by Alexander Smith on 1/24/20.
//  Copyright © 2020 Alexander Smith. All rights reserved.
//

import Foundation

class WeatherViewModel: ObservableObject {
  private var weatherService: WeatherService!
  
  @Published var weather = Weather()
  
  init() {
    // Initialize Network Service
    self.weatherService = WeatherService()
  }
  
  var temperature: String {
    if let temp = self.weather.temp {
      return String(format: "%.0f", temp)
    } else {
      return ""
    }
  }
  
  var humidity: String {
    if let humidity = self.weather.humidity {
      return String(format: "%.0f", humidity)
    } else {
      return ""
    }
  }
  
  var cityName: String = ""
  
  func search() {
    // Safe Guard for Name Spacing
    if let city = self.cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
      fetchWeather(by: city)
    }
  }
  
  // Weather API Request
  private func fetchWeather(by city: String) {
    self.weatherService.getWeather(city: city) { weather in
      if let weather = weather {
        self.weather = weather
      }
    }
  }
}
