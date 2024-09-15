//
//  LaunchManager.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/15/24.
//

import Foundation

enum LaunchState {
    case loadCurrentLocation(WeatherEntry.Coordinates)
    case loadPreviousSearch(String)
    case empty
}

class LaunchManager {

    let userData: UserDataProtocol
    let weatherScreenViewModel: WeatherScreenViewModel

    internal init(userData: any UserDataProtocol, weatherScreenViewModel: WeatherScreenViewModel) {
        self.userData = userData
        self.weatherScreenViewModel = weatherScreenViewModel
    }

    func beginAppLaunch() {
        Task { @MainActor in
            let launchState = await launchState()
            handleLaunchState(launchState)
        }
    }

    func handleLaunchState(_ launchState: LaunchState) {
        switch launchState {
        case .loadCurrentLocation:
            // Search based on coordinates
            break
        case .loadPreviousSearch(let previousSearch):
            weatherScreenViewModel.getWeather(search: previousSearch)
        case .empty:
            break
        }
    }

    func launchState() async -> LaunchState {
        if let previousSearch = userData.getLastSearch() {
            return .loadPreviousSearch(previousSearch)
        } else {
            return .empty
        }
    }
}
