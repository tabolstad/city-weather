//
//  WeatherDetailViewModel.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import Foundation

class WeatherDetailViewModel {

    let weather: WeatherEntry

    init(weather: WeatherEntry) {
        self.weather = weather
    }

    var name: String {
        weather.name
    }

    var temperature: Int {
        Int(weather.main.temperature.rounded())
    }

    var tempFeelsLike: Int {
        Int(weather.main.tempFeelsLike.rounded())
    }

    var tempHigh: Int {
        Int(weather.main.tempMax.rounded())
    }

    var tempLow: Int {
        Int(weather.main.tempMin.rounded())
    }
}
