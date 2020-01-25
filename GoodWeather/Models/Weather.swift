//
//  Weather.swift
//  GoodWeather
//
//  Created by Alexander Smith on 1/24/20.
//  Copyright © 2020 Alexander Smith. All rights reserved.
//

import Foundation

// API JSON Data
struct WeatherResponse: Decodable {
  let main: Weather
}

// Decoded Weather Object
struct Weather: Decodable {
  var temp: Double?
  var humidity: Double?
}
