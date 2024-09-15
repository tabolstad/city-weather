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
    case finished(Value)
    case error(Error)
}

@Observable class WeatherScreenViewModel {
    var state: LoadingState<WeatherEntry> = .idle
    var api = OpenWeather()

    func getWeather() async {
        state = .loading
        do {
            let response = try await api.getWeather(city: "Palatine", state: nil)
            state = .finished(WeatherEntry(response: response))
        } catch {
            state = .error(error)
        }
    }
}
