//
//  WeatherDetailViewModel.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import Foundation

protocol WeatherDetailDelegate: AnyObject {
    func performSearch(city: String)
}

@Observable
class WeatherContentViewModel {

    weak var delegate: WeatherDetailDelegate?

    var weather: WeatherEntry

    internal init(weather: WeatherEntry) {
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

extension WeatherContentViewModel: SearchViewDelegate {

    func performSearch(city: String) {
        delegate?.performSearch(city: city)
    }
}
