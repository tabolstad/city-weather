//
//  LaunchManager.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/15/24.
//

import Foundation
import CoreLocation

enum LaunchState {
    case loadCurrentLocation(WeatherEntry.Coordinates)
    case loadPreviousSearch(String)
    case empty
}

enum LocationError: Error {
    case locationPermissionsUnuthorized
    case locationServicesDisabled
}

class LaunchManager: NSObject, CLLocationManagerDelegate {

    let userData: UserDataProtocol
    let weatherScreenViewModel: WeatherScreenViewModel
    var locationManager: CLLocationManager?

    private var locationContinuation: CheckedContinuation<WeatherEntry.Coordinates, any Error>?

    internal init(userData: any UserDataProtocol, weatherScreenViewModel: WeatherScreenViewModel) {
        self.userData = userData
        self.weatherScreenViewModel = weatherScreenViewModel

        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager = locationManager

        super.init()
        locationManager.delegate = self
    }

    func beginAppLaunch() {
        Task { @MainActor in
            let launchState = await launchState()
            await handleLaunchState(launchState)
        }
    }

    func handleLaunchState(_ launchState: LaunchState) async {
        switch launchState {
        case .loadCurrentLocation(let coordinates):
            weatherScreenViewModel.getWeather(coordinates: coordinates)
        case .loadPreviousSearch(let previousSearch):
            weatherScreenViewModel.getWeather(search: previousSearch)
        case .empty:
            break
        }
    }

    func launchState() async -> LaunchState {

        if let currentLocation = try? await getCurrentLocation() {
            return .loadCurrentLocation(currentLocation)
        } else if let previousSearch = userData.getLastSearch() {
            return .loadPreviousSearch(previousSearch)
        } else {
            return .empty
        }
    }

    func getCurrentLocation() async throws -> WeatherEntry.Coordinates {

        let location = try await withCheckedThrowingContinuation { continuation in

            locationContinuation = continuation

            let locationAuthorizationStatus = locationManager?.authorizationStatus
            switch locationAuthorizationStatus {
            case .notDetermined:
                Task { @MainActor in
                    locationManager?.requestWhenInUseAuthorization()
                }
            case .authorizedWhenInUse, .authorizedAlways:
                if CLLocationManager.locationServicesEnabled() {
                    Task { @MainActor in
                        locationManager?.startUpdatingLocation()
                    }
                } else {
                    locationContinuation?.resume(throwing: LocationError.locationServicesDisabled)
                }
            default:
                locationContinuation?.resume(throwing: LocationError.locationPermissionsUnuthorized)
                locationContinuation = nil
            }
        }
        return location
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        print(status)
        switch status {
        case .notDetermined:
            return
        case .authorizedWhenInUse, .authorized, .authorizedAlways:
            locationManager?.startUpdatingLocation()
        default:
            locationContinuation?.resume(throwing: LocationError.locationPermissionsUnuthorized)
            locationContinuation = nil
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.last {
            let coord = WeatherEntry.Coordinates(
                longitude: location.coordinate.longitude,
                latitude: location.coordinate.latitude
            )
            locationContinuation?.resume(returning: coord)
            locationContinuation = nil
            locationManager?.stopUpdatingLocation()
        } else {
            locationContinuation?.resume(throwing: LocationError.locationPermissionsUnuthorized)
            locationContinuation = nil
        }
    }
}
