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
class WeatherDetailViewModel {

    weak var delegate: WeatherDetailDelegate?

    var weather: WeatherEntry
    var temperatureUnit = "℉"

    internal init(weather: WeatherEntry) {
        self.weather = weather
    }

    var name: String {
        weather.name
    }

    var temperature: String {
        String(Int(weather.temperature.rounded())) + temperatureUnit
    }

    var tempFeelsLike: String {
        String(Int(weather.tempFeelsLike.rounded())) + temperatureUnit
    }

    var tempHigh: String {
        String(Int(weather.tempMax.rounded())) + temperatureUnit
    }

    var tempLow: String {
        String(Int(weather.tempMin.rounded())) + temperatureUnit
    }

    var humidity: String {
        String(weather.humidity) + "%"
    }

    var pressure: String {
        String(weather.pressure) + " hPa"
    }

    var windSpeed: String {
        String(Int(weather.windSpeed.rounded())) + " mph"
    }

    var windDirection: String {
        String(weather.windDirection) + "°"
    }

    var weatherIcon: URL? {
        if let weatherIcon = weather.weatherIcon {
            return URL(string: weatherIcon)
        } else {
            return nil
        }
    }
}

extension WeatherDetailViewModel: SearchViewDelegate {

    func performSearch(city: String) {
        delegate?.performSearch(city: city)
    }
}
