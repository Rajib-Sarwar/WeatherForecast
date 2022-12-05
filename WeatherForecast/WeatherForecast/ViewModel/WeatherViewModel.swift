//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by Chowdhury Md Rajib  Sarwar on 3/12/22.
//

import Foundation
import Combine
import CoreLocation

class WeatherViewModel {
    
    //MARK: Dependency Injection
    private let apiManager: NetworkManager
    private let appURL: RestURL
    
    var currentWeatherSubject = PassthroughSubject<WeatherData, Error>()
    var forecastSubject = PassthroughSubject<ForecastData, Error>()

    init(apiManager: NetworkManager, appURL: RestURL) {
        self.apiManager = apiManager
        self.appURL = appURL
    }
    
    func getURL(of coordinate: CLLocationCoordinate2D) -> URL {
        return URL(string: appURL.urlString + "?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(APIKey.openWeather)&units=imperial")!
    }
    
    func getForecast(of coordinate: CLLocationCoordinate2D) {
        apiManager.getData(url: getURL(of: coordinate)) { [weak self] (result: Result<ForecastData, Error>) in
            switch result {
            case .success(let forecasts):
                self?.forecastSubject.send(forecasts)
            case .failure(let error):
                self?.forecastSubject.send(completion: .failure(error))
            }
        }
    }
    
    func getCurrentWeather(of coordinate: CLLocationCoordinate2D) {
        apiManager.getData(url: getURL(of: coordinate)) { [weak self] (result: Result<WeatherData, Error>) in
            switch result {
            case .success(let weather):
                print(weather)
                self?.currentWeatherSubject.send(weather)
            case .failure(let error):
                self?.currentWeatherSubject.send(completion: .failure(error))
            }
        }
    }
}
