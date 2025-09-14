//
//  ViewController.swift
//  weather app uikit
//
//  Created by Nam Pham on 7/9/25.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    @IBOutlet weak var iconImg: UIImageView!
    
    let WEATHER_API_KEY: String = "347b203f58ab437cb9c115827251309"
    
    private let locationManager: LocationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Home"
        
        Task {
            let location = await locationManager.requestLocation()
            print("Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            
            await fetchData(location: location)
        }
    }

    func fetchData(location: CLLocation) async {
        do {
            let latLon = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
            let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(WEATHER_API_KEY)&q=\(latLon)&aqi=no");
            let (data, _) = try await URLSession.shared.data(from: url!)
            let json = try JSONSerialization.jsonObject(with: data) as! [String : Any]
            print("Response JSON: \(json)")
            
            if let _location = json["location"] as? [String: Any],
               let _city = _location["name"] as? String{
                self.cityLabel.text = "\(_city) city"
            }
            
            if let _current = json["current"] as? [String: Any] {
                if let _temp_c = _current["temp_c"] as? Double {
                    self.temperatureLabel.text = "\(_temp_c) °C"
                }
                
                if let _condition = _current["condition"] as? [String: Any],
                   let _text = _condition["text"] as? String,
                   let _icon = _condition["icon"] as? String {
                    self.conditionLabel.text = _text
                    
                    let _url = URL(string: "https:\(_icon)")!
                    self.loadIcon(fromUrl: _url)
                }
            }
        } catch {
            print("Error: \(error)")
        }
    }

    func loadIcon(fromUrl: URL) {
        URLSession.shared.dataTask(with: fromUrl) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.iconImg.image = image
                }
            } else {
                print("Failed to load image", error ?? "Uknown error")
            }
        }.resume()
    }
}

