//
//  Helper.swift
//  weather app uikit
//
//  Created by Nam Pham on 14/9/25.
//

import Foundation
import UIKit

class Helper {
    let API_KEY: String = "347b203f58ab437cb9c115827251309"
    let API_URL: String = "https://api.weatherapi.com/v1/"
    
    func getWeatherURL(apiURL: String) -> URL {
        return URL(string: "\(API_URL)\(apiURL)&key=\(API_KEY)&aqi=no")!
    }
    
    func loadIcon(fromUrl: URL, to iconImg: UIImageView) {
        URLSession.shared.dataTask(with: fromUrl) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    iconImg.image = image
                }
            } else {
                print("Failed to load image", error ?? "Uknown error")
            }
        }.resume()
    }
}
