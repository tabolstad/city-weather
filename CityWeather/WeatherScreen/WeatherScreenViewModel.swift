//
//  WeatherScreenViewModel.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import Foundation

enum LoadingState<Value> {
    case idle
    case loading
    case finished
    case error(Error)
}

@Observable class WeatherScreenViewModel {

    var state: LoadingState<WeatherEntry> = .idle
    var api = OpenWeather()
    var contentViewModel: WeatherDetailViewModel

    internal init() {
        self.contentViewModel = WeatherDetailViewModel(weather: WeatherEntry.placeholder)
    }

    func getWeather(search: String) async {

        state = .loading

        do {
            let response = try await api.getWeather(city: search, state: nil)
            Task { @MainActor in
                contentViewModel.weather = WeatherEntry(response: response)
                state = .finished
            }
        } catch {
            state = .error(error)
        }
    }
}

extension WeatherScreenViewModel: SearchViewDelegate {
    func performSearch(city: String) {
        Task {
            await getWeather(search: city)
        }
    }
}
