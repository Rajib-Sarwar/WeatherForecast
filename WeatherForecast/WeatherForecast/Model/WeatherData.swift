//
//  Weather.swift
//  WeatherForecast
//
//  Created by Chowdhury Md Rajib  Sarwar on 3/12/22.
//

import Foundation

struct WeatherData: Codable {
    var weather: [Weather]
    var base: String
    var main: Main
    var id: Int
    var name: String
}


/**
 {
     "coord": {...},
     "weather": [...],
     "base": "stations",
     "main": {...},
     "visibility": 10000,
     "wind": {...},
     "clouds": {...},
     "dt": 1670104300,
     "sys": {...},
     "timezone": -18000,
     "id": 5098863,
     "name": "Harrison",
     "cod": 200
 }
 **/
