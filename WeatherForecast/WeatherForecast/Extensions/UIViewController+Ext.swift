//
//  UIViewController+Ext.swift
//  WeatherForecast
//
//  Created by Chowdhury Md Rajib  Sarwar on 4/12/22.
//

import UIKit

extension UIViewController {
    func presentSettingAlert() {
        let alert = UIAlertController(title: "Sorry!",
                                      message: "Give location access to get accurate weather forecast",
                                      preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        let settingsButton = UIAlertAction(title: "Settings", style: .destructive, handler: { UIAlertAction in
            if let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION_SERVICES") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        alert.addAction(okButton)
        alert.addAction(settingsButton)
        self.present(alert, animated: true)
        
        
    }
    
    func presentAlert(title: String = "Sorry!", message: String, buttonTitle: String = "OK") {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
    }

    func presentDefaultAlert() {
        let alert = UIAlertController(title: "Something went wrong",
                                      message: "We were unable to complete your task at this time. Please try again.",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
    }
}


