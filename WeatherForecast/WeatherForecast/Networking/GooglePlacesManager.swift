//
//  GooglePlacesManager.swift
//  WeatherForecast
//
//  Created by Chowdhury Md Rajib  Sarwar on 4/12/22.
//

import Foundation
import GooglePlaces

final class GooglePlacesManager {
    
    static let shared = GooglePlacesManager()
    private init() {}
    
    private let client = GMSPlacesClient.shared()
    
    func findPlaces(query: String, completion: @escaping (Result<[PlaceData], Error>) -> Void) {
        client.findAutocompletePredictions(
            fromQuery: query,
            filter: GMSAutocompleteFilter(),
            sessionToken: nil) { results, error in
                guard let results = results, error == nil else {
                    completion(.failure(PlacesError.failedToFind))
                    return
                }
                
                let places: [PlaceData] = results.compactMap({
                    PlaceData(id: $0.placeID, name: $0.attributedFullText.string)
                })
                completion(.success(places))
            }
    }
    
    public func getLocationCoordinate(for place: PlaceData, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        client.fetchPlace(fromPlaceID: place.id, placeFields: .coordinate, sessionToken: nil) { googlePlace, error in
            guard let googlePlace = googlePlace, error == nil else {
                completion(.failure(PlacesError.failedToGetCoordinates))
                return
            }
            completion(.success(googlePlace.coordinate))
        }
    }
}
