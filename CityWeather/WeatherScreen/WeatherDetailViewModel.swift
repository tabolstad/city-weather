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
        Int(weather.temperature.rounded())
    }

    var tempFeelsLike: Int {
        Int(weather.tempFeelsLike.rounded())
    }

    var tempHigh: Int {
        Int(weather.tempMax.rounded())
    }

    var tempLow: Int {
        Int(weather.tempMin.rounded())
    }

    var weatherIcon: URL? {
        if let weatherIcon = weather.weatherIcon {
            return URL(string: weatherIcon)
        } else {
            return nil
        }
    }
}

extension WeatherContentViewModel: SearchViewDelegate {

    func performSearch(city: String) {
        delegate?.performSearch(city: city)
    }
}
