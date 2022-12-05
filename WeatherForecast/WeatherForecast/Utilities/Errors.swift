//
//  Errors.swift
//  WeatherForecast
//
//  Created by Chowdhury Md Rajib  Sarwar on 4/12/22.
//

import Foundation

enum PlacesError: Error {
    case failedToFind
    case failedToGetCoordinates
}
