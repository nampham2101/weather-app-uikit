//
//  Helper.swift
//  weather app uikit
//
//  Created by Nam Pham on 14/9/25.
//

import Foundation

class Helper {
    let API_KEY: String = "347b203f58ab437cb9c115827251309"
    let API_URL: String = "https://api.weatherapi.com/v1/"
    
    func getWeatherURL(apiURL: String) -> URL {
        return URL(string: "\(API_URL)\(apiURL)&key=\(API_KEY)&aqi=no")!
    }
}
