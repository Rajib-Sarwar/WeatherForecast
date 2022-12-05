//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Chowdhury Md Rajib  Sarwar on 2/12/22.
//

import UIKit
import Combine
import CoreLocation

class CurrentWeatherViewController: UIViewController {

    @IBOutlet weak var vwWeather: UIView!
    @IBOutlet weak var tfCity: UILabel!
    @IBOutlet weak var tfTemperature: UILabel!
    @IBOutlet weak var tfRange: UILabel!
    @IBOutlet weak var tfDescription: UILabel!
    @IBOutlet weak var ivIcon: UIImageView!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
        
    let searchPlaceController = UISearchController(searchResultsController: PlacesViewController())
    let locationManager = CLLocationManager()
    
    var weatherViewModel: WeatherViewModel!
    private let apiManger = NetworkManager()
    private var subscriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = true
        weatherView(isHidden: true)
        setupLocation()
        setupSearchLocationView()
        setupViewModel()
        observeWeatherViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func setupViewModel() {
        weatherViewModel = WeatherViewModel(apiManager: apiManger, appURL: .weather)
    }
    
    func fetchWeather() {
        guard let currentLocation = Global.shared.location else { return }
        weatherViewModel.getCurrentWeather(of: currentLocation.coordinate)
    }
    
    func observeWeatherViewModel() {
        subscriber = weatherViewModel.currentWeatherSubject.sink { (resultCompletion) in
            self.weatherView(isHidden: false)
            switch resultCompletion {
            case .failure(let error):
                self.presentAlert(message: error.localizedDescription)
            case .finished: break
            }
        } receiveValue: { (weather) in
            DispatchQueue.main.async {
                self.updateView(with: weather)
            }
        }
    }
    
    func updateView(with data: WeatherData) {
        self.weatherView(isHidden: false)
        self.tfCity.text =  data.name
        self.tfTemperature.text = "\(data.main.temp)"
        if let weather = data.weather.first {
            self.tfDescription.text = weather.description.capitalized
            self.ivIcon.load(from: API.BASE.IMAGE_URL + weather.icon + ImageType.png)
        }
        self.tfRange.text = "H: \(data.main.temp_max)   L: \(data.main.temp_min)"
    }
    
    func weatherView(isHidden: Bool) {
        vwWeather.isHidden = isHidden
        indicatorView.isHidden = !isHidden
    }
}


extension CurrentWeatherViewController: CLLocationManagerDelegate {
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, Global.shared.location == nil {
            Global.shared.location = locations.first
            locationManager.stopUpdatingLocation()
            fetchWeather()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.presentSettingAlert()
        Global.shared.location = CLLocation(latitude: DefaultCoordinates.latitude,
                                            longitude: DefaultCoordinates.longitude)
        fetchWeather()
    }
}

extension CurrentWeatherViewController: UISearchResultsUpdating {
    func setupSearchLocationView() {
        searchPlaceController.searchBar.searchTextField.backgroundColor = Color.lightBlue
        searchPlaceController.searchResultsUpdater = self
        navigationItem.searchController = searchPlaceController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
            !query.trimmingCharacters(in: .whitespaces).isEmpty,
              let locationsVC = searchController.searchResultsController as? PlacesViewController else {
            return
        }
        locationsVC.delegate = self
        getPlaces(for: query, on: locationsVC)
    }
    
    func getPlaces(for query: String, on viewController: PlacesViewController) {
        GooglePlacesManager.shared.findPlaces(query: query) { result in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    viewController.update(with: places)
                }
            case .failure(let error):
                self.presentAlert(message: error.localizedDescription)
            }
        }
    }
}

extension CurrentWeatherViewController: PlacesViewControllerDelegate {
    func onSelectPlace(in coordinates: CLLocationCoordinate2D) {
        weatherView(isHidden: true)
        searchPlaceController.dismiss(animated: true)
        Global.shared.location = CLLocation(latitude: coordinates.latitude,
                                            longitude: coordinates.longitude)
        fetchWeather()
    }
}

extension CurrentWeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
