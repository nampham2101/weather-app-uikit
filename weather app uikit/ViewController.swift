//
//  ViewController.swift
//  weather app uikit
//
//  Created by Nam Pham on 7/9/25.
//

import UIKit

class ViewController: UIViewController {
    let WEATHER_API_KEY: String = "347b203f58ab437cb9c115827251309"
    let WEATHER_URL: String = "http://api.weatherapi.com/v1/current.json?key="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Home"
        
        Task {
            await self.fetchData()
        }
    }

    func fetchData() async {
        do {
            let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(WEATHER_API_KEY)&q=London&aqi=no");
            let (data, _) = try await URLSession.shared.data(from: url!)
            let json = try JSONSerialization.jsonObject(with: data)
            print("Response JSONL: \(json)")
        } catch {
            print("Error: \(error)")
        }
    }

}

