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

    func getWeather(search: String) async {

        state = .loading

        do {
            let response = try await api.getWeather(city: search, state: nil)
            await handleWeatherResponse(response: response)
        } catch {
            state = .error(error)
        }
    }

    func getWeather(coordinates: WeatherEntry.Coordinates) async {

        state = .loading

        do {
            let response = try await api.getWeather(longitude: coordinates.longitude, latitude: coordinates.latitude)
            await handleWeatherResponse(response: response)
        } catch {
            state = .error(error)
        }
    }

    @MainActor
    private func handleWeatherResponse(response: WeatherResponse) async {
        detailViewModel.weather = WeatherEntry(response: response)
        state = .finished
    }
}

extension WeatherScreenViewModel: SearchViewDelegate {
    func performSearch(city: String) {
        Task  {
            await getWeather(search: city)
        }
    }
}
