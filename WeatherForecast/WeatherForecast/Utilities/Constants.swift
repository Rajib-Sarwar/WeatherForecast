//
//  Constants.swift
//  WeatherForecast
//
//  Created by Chowdhury Md Rajib  Sarwar on 4/12/22.
//

import UIKit

enum DefaultCoordinates {
    static let latitude = 37.3230
    static let longitude = 122.0322
}

enum Color {
    static let darkBlue = UIColor(named: "DarkBlue")
    static let lightBlue = UIColor(named: "LightBlue")
}

enum SFSymbols {
    static let calender = UIImage(systemName: "calendar")
}

enum ReuseableID {
    static let forecastCell = "ForecastTableCellID"
    static let placesCell = "PlacesTableCellID"
}

enum ImageType {
    static let png = "@2x.png"
}

enum APIKey {
    static let googlePlaces = "AIzaSyD8Cc4OGc9k50vHF_Mk1EsDiXL6xnFqjJM"
    static let openWeather = "7fa1c1860de09de65a5951154ef81353"
}

enum API {
    enum BASE {
        static let URL = "https://api.openweathermap.org/data/2.5/"
        static let IMAGE_URL = "http://openweathermap.org/img/wn/"
    }
    
    enum ENDPOINT {
        static let FORECAST = "forecast"
        static let WEATHER = "weather"
    }
}

enum RestURL {
    case forecast
    case weather
    var urlString: String {
        switch self {
        case .forecast:
            return API.BASE.URL + API.ENDPOINT.FORECAST
        case .weather:
            return API.BASE.URL + API.ENDPOINT.WEATHER
        }
    }
}
