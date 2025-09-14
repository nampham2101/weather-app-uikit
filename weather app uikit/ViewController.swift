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
                print("HI NAM \(_location) - \(_city)")
                self.cityLabel.text = "\(_city) city"
            }
        } catch {
            print("Error: \(error)")
        }
    }

}

