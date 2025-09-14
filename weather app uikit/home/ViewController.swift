//
//  ViewController.swift
//  weather app uikit
//
//  Created by Nam Pham on 7/9/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    @IBOutlet weak var iconImg: UIImageView!
    
    private let locationManager: LocationManager = LocationManager()
    private let weatherManager: WeatherManager = WeatherManager()
    private let helper: Helper = Helper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Home"
        
        Task {
            let location = await locationManager.requestLocation()
            
            if let weatherData = await weatherManager.current(location: location) {
                self.cityLabel.text = "\(weatherData.location.name) city"
                self.temperatureLabel.text = "\(weatherData.current.temp_c) °C"
                self.conditionLabel.text = weatherData.current.condition.text
                let _url = URL(string: "https:\(weatherData.current.condition.icon)")!
                helper.loadIcon(fromUrl: _url, to: self.iconImg)
            }
        }
    }
}

