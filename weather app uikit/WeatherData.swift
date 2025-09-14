//
//  WeatherData.swift
//  weather app uikit
//
//  Created by Nam Pham on 14/9/25.
//

struct WeatherCondition: Codable {
    let text: String
    let icon: String
}

struct CurrentWeather: Codable {
    let temp_c: Double
    let condition: WeatherCondition
}

struct Location: Codable {
    let name: String
}

struct WeatherData: Codable {
    let location: Location
    let current: CurrentWeather
}
