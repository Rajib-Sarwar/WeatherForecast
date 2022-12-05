//
//  Forecast.swift
//  WeatherForecast
//
//  Created by Chowdhury Md Rajib  Sarwar on 2/12/22.
//

import Foundation

struct ForecastData: Codable {
    var message: Int
    var list: [List]
    var city: City
}

/**
 "cod": "200",
 "message": 0,
 "cnt": 40,
 "list":[...],
 "city": {...}
 **/

struct List: Codable {
    var dt: Int
    var main: Main
    var weather: [Weather]
    var dt_txt: String
}

/**
  "dt": 1670036400,
  "main": {...},
  "weather": [{...}],
  "clouds": {...},
  "wind": {...},
  "visibility": 2426,
  "pop": 0.94,
  "rain": {...},
  "dt_txt": "2022-12-03 03:00:00"
**/

struct Main: Codable {
    var temp: Double
    var temp_min: Double
    var temp_max: Double
}
/**
 "temp": 276.08,
 "feels_like": 276.08,
 "temp_min": 276.08,
 "temp_max": 276.16,
 "pressure": 1017,
 "sea_level": 1017,
 "grnd_level": 929,
 "humidity": 92,
 "temp_kf": -0.08
 **/

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}
/**
 "id": 500,
 "main": "Rain",
 "description": "light rain",
 "icon": "10n"
 **/

struct City: Codable {
    var id: Int
    var name: String
    var country: String
}

/**
 "id": 3163858,
 "name": "Zocca",
 "coord": {..},
 "country": "IT",
 "population": 4593,
 "timezone": 3600,
 "sunrise": 1670049238,
 "sunset": 1670081877
 **/
