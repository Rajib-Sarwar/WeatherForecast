//
//  ForecastViewController.swift
//  WeatherForecast
//
//  Created by Chowdhury Md Rajib  Sarwar on 3/12/22.
//

import UIKit
import Combine
import CoreLocation

class ForecastViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var weatherViewModel: WeatherViewModel!
    private let apiManger = NetworkManager()
    private var subscriber: AnyCancellable?
    
    var forecastList = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastView(isHidden: true)
        tableView.register(UINib(nibName: "ForecastTableViewCell", bundle: nil),
                           forCellReuseIdentifier: ReuseableID.forecastCell)
        setupViewModel()
        observeWeatherViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchForecast()
    }
    
    func forecastView(isHidden: Bool) {
        tableView.isHidden = isHidden
        indicatorView.isHidden = !isHidden
    }
    
    func setupViewModel() {
        weatherViewModel = WeatherViewModel(apiManager: apiManger, appURL: .forecast)
    }
    
    func fetchForecast() {
        guard let currentLocation = Global.shared.location else { return }
        weatherViewModel.getForecast(of: currentLocation.coordinate)
    }

    func observeWeatherViewModel() {
        subscriber = weatherViewModel.forecastSubject.sink { (resultCompletion) in
            self.forecastView(isHidden: false)
            switch resultCompletion {
            case .failure(let error):
                self.presentAlert(message: error.localizedDescription)
            case .finished: break
            }
        } receiveValue: { (forecast) in
            self.forecastList = forecast.list.removeRedundant()
            DispatchQueue.main.async {
                self.forecastView(isHidden: false)
                self.tableView.reloadData()
            }
        }
    }
}

extension ForecastViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel()
        label.frame = CGRect.init(x: 15, y: 5, width: headerView.frame.width-15, height: headerView.frame.height)
        label.addLeading(image: SFSymbols.calender!, with: " 5-DAYS FORECAST")
        label.font = .systemFont(ofSize: 16)
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseableID.forecastCell, for: indexPath) as! ForecastTableViewCell
        let forecast = forecastList[indexPath.row]
        cell.lblDate.text = forecast.dt_txt.convertToCustomDate()
        if let weather = forecast.weather.first {
            cell.lblCondition.text = weather.main
            cell.ivIcon.load(from: API.BASE.IMAGE_URL + weather.icon + ImageType.png)
        }
        cell.lblRange.text = "H: \(forecast.main.temp_max) \n L: \(forecast.main.temp_min)"
        
        return cell
    }
}
