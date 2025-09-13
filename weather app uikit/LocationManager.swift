//
//  LocationManager.swift
//  weather app uikit
//
//  Created by Nam Pham on 13/9/25.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var continuation: CheckedContinuation<CLLocation, Never>?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization() // ask permission
    }
    
    func requestLocation() async -> CLLocation {
        return await withCheckedContinuation { continuation in
            self.continuation = continuation
            manager.requestLocation() // only gets 1 location
        }
    }
    
    // Delegate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            continuation?.resume(returning: location)
            continuation = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed: \(error.localizedDescription)")
    }
}
