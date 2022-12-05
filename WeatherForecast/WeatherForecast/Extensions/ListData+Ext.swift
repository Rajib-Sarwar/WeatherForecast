//
//  ForcastData+Ext.swift
//  WeatherForecast
//
//  Created by Chowdhury Md Rajib  Sarwar on 4/12/22.
//

import Foundation

extension [List] {
    func removeRedundant() -> [List] {
        var forecastList = [List]()
        var string = ""
        for current in self {
            if(string.isEmpty || string != current.dt_txt.convertToCustomDate()) {
                string = current.dt_txt.convertToCustomDate()
                forecastList.append(current)
            }
        }
        return forecastList
    }
}
