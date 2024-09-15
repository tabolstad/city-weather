//
//  WeatherEntryMock.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import Foundation

extension WeatherEntry {
    static var mock: WeatherEntry {

        let coord = WeatherEntry.Coordinates(
            longitude: -73.9866,
            latitude: 40.7306
        )

        let main = WeatherEntry.MainData(
            temperature: 71.85,
            tempFeelsLike: 72.21,
            tempMin: 69.01,
            tempMax: 73.94,
            pressure: 1023,
            humidity: 74,
            seaLevel: 1023,
            groundLevel: 1021)

        let wind = WeatherEntry.Wind(
            speed: 4.61,
            degrees: 140
        )

        let weather = WeatherEntry(
            id: 5128581,
            name: "New York",
            coordinates: coord,
            main: main,
            wind: wind
        )

        return weather
    }
}
