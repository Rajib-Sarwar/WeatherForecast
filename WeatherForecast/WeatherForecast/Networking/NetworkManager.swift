//
//  APIManager.swift
//  WeatherForecast
//
//  Created by Chowdhury Md Rajib  Sarwar on 2/12/22.
//

import Foundation
import Combine
import UIKit

class NetworkManager {
    
    private var subscribers = Set<AnyCancellable>()
    
    func getData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .sink { (resultCompletion) in
                switch resultCompletion {
                case .failure(let error):
                    completion(.failure(error))
                case .finished: break
                }
            } receiveValue: { (result) in
                completion(.success(result))
            }
            .store(in: &subscribers)
    }
}





