//
//  WeatherScreenViewModel.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import Foundation
import SwiftUI

enum LoadingState<Value> {
    case idle
    case loading
    case finished
    case error(Error)
}

@Observable class WeatherScreenViewModel {

    var userData: UserDataProtocol
    var state: LoadingState<WeatherEntry> = .idle
    var api: WeatherAPI
    var detailViewModel: WeatherDetailViewModel
    var enableLocation: Bool {
        didSet {
            userData.enableLocation = enableLocation
        }
    }

    internal init(api: WeatherAPI = OpenWeather(), userData: UserDataProtocol = UserData()) {
        self.api = api
        self.userData = userData
        self.detailViewModel = WeatherDetailViewModel(weather: WeatherEntry.placeholder)
        self.enableLocation = userData.enableLocation
    }

    func getWeather(search: String) {

        state = .loading

        Task {
            do {
                let response = try await api.getWeather(city: search, state: nil)
                Task { @MainActor in
                    detailViewModel.weather = WeatherEntry(response: response)
                    state = .finished
                    userData.saveLastSeach(search)
                }
            } catch {
                state = .error(error)
            }
        }
    }

    func getWeather(coordinates: WeatherEntry.Coordinates) {

        state = .loading

        Task {
            do {
                let response = try await api.getWeather(longitude: coordinates.longitude, latitude: coordinates.latitude)
                Task { @MainActor in
                    detailViewModel.weather = WeatherEntry(response: response)
                    state = .finished
                }
            } catch {
                state = .error(error)
            }
        }
    }
}

extension WeatherScreenViewModel: SearchViewDelegate {
    func performSearch(city: String) {
        getWeather(search: city)
    }
}
