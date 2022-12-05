//
//  Global.swift
//  WeatherForecast
//
//  Created by Chowdhury Md Rajib  Sarwar on 4/12/22.
//

import Foundation
import CoreLocation

class Global {
    private init() {}
    static let shared = Global()
    
    var location: CLLocation? = nil
}
