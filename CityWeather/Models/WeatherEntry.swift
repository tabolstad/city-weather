//
//  Weather.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import Foundation

/// Representation of the weather data for a single weather screen
struct WeatherEntry {

    let id: Int
    let name: String
    let coordinates: Coordinates
    let weatherIcon: String?

    let temperature: Double
    let tempFeelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int

    let windSpeed: Double
    let windDirection: Int // Degrees

    struct Coordinates {
        let longitude: Double
        let latitude: Double
    }

    internal init(id: Int, name: String, coordinates: WeatherEntry.Coordinates, weatherIcon: String, temperature: Double, tempFeelsLike: Double, tempMin: Double, tempMax: Double, pressure: Int, humidity: Int, windSpeed: Double, windDirection: Int) {
        self.id = id
        self.name = name
        self.coordinates = coordinates
        self.weatherIcon = weatherIcon
        self.temperature = temperature
        self.tempFeelsLike = tempFeelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.windDirection = windDirection
    }

    init(response: WeatherResponse) {

        self.id = response.id
        self.name = response.name

        let main = response.main
        self.temperature  = main.temp
        self.tempFeelsLike = main.feels_like
        self.tempMin = main.temp_min
        self.tempMax = main.temp_max
        self.pressure = main.pressure
        self.humidity = main.humidity

        let wind = response.wind
        self.windSpeed = wind.speed
        self.windDirection = wind.deg

        self.coordinates = Coordinates(
            longitude: response.coord.lon,
            latitude: response.coord.lat
        )

        if let weather = response.weather.first {
            self.weatherIcon = Self.createIconUrl(key: weather.icon)
        } else {
            self.weatherIcon = nil
        }
    }

    static func createIconUrl(key: String) -> String {
        return "https://openweathermap.org/img/wn/\(key)@2x.png"
    }
}

extension WeatherEntry {

    static var placeholder: WeatherEntry {

        let coord = WeatherEntry.Coordinates(
            longitude: -73.9866,
            latitude: 40.7306
        )

        let icon = "https://openweathermap.org/img/wn/10d@2x.png"

        let weather = WeatherEntry(
            id: 5128581,
            name: "New York",
            coordinates: coord,
            weatherIcon: icon,
            temperature: 71.85,
            tempFeelsLike: 72.21,
            tempMin: 69.01,
            tempMax: 73.94,
            pressure: 1023,
            humidity: 74,
            windSpeed: 4.61,
            windDirection: 140
        )
        return weather
    }
}
