//
//  WeatherManager.swift
//  weather app uikit
//
//  Created by Nam Pham on 14/9/25.
//

import CoreLocation

class WeatherManager {
    private let helper = Helper();
    
    func current(location: CLLocation) async -> WeatherData? {
        let latLon = "\(location.coordinate.latitude), \(location.coordinate.longitude)"
        
        return await fetchData(location: location, url: helper.getWeatherURL(apiURL: "current.json?q=\(latLon)"))
    }
    
    private func fetchData(location: CLLocation, url: URL) async -> WeatherData? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(WeatherData.self, from: data)
        } catch {
            print("Fectching data failed: \(error)")
            return nil
        }
    }
}
