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
            return try await NetworkManager.shared.request(url, type: WeatherData.self)
        } catch let apiError as ApiError {
            print("NAMPHAM - API Error: \(NetworkManager.shared.getErrorMessage(apiError))")
            return nil
        } catch {
            print("Fectching data failed: \(error)")
            return nil
        }
    }
}
