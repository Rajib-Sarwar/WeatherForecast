//
//  String+Ext.swift
//  WeatherForecast
//
//  Created by Chowdhury Md Rajib  Sarwar on 4/12/22.
//

import Foundation

extension String {
    func convertToCustomDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: self)!
        
        formatter.dateFormat = "EEEE, MMM d"
        return formatter.string(from: date)
    }
}
