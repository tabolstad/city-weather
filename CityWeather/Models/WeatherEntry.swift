//
//  Weather.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import Foundation

struct WeatherEntry {

    let id: Int
    let name: String
    let coordinates: Coordinates
    let main: MainData
    let wind: Wind

    struct Coordinates {
        let longitude: Double
        let latitude: Double
    }

    struct MainData {
        let temperature: Double
        let tempFeelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let humidity: Int
        let seaLevel: Int
        let groundLevel: Int
    }

    struct Wind {
        let speed: Double
        let degrees: Int
    }

    internal init(id: Int, name: String, coordinates: WeatherEntry.Coordinates, main: WeatherEntry.MainData, wind: WeatherEntry.Wind) {
        self.id = id
        self.name = name
        self.coordinates = coordinates
        self.main = main
        self.wind = wind
    }

    init(response: WeatherResponse) {

        let coord = WeatherEntry.Coordinates(
            longitude: response.coord.lon,
            latitude: response.coord.lat
        )

        let main = WeatherEntry.MainData(
            temperature: response.main.temp,
            tempFeelsLike: response.main.feels_like,
            tempMin: response.main.temp_min,
            tempMax: response.main.temp_max,
            pressure: response.main.pressure,
            humidity: response.main.humidity,
            seaLevel: response.main.sea_level,
            groundLevel: response.main.grnd_level)

        let wind = WeatherEntry.Wind(
            speed: response.wind.speed,
            degrees: response.wind.deg
        )

        self.id = response.sys.id
        self.name = response.name
        self.coordinates = coord
        self.main = main
        self.wind = wind
    }
}

extension WeatherEntry {

    static var placeholder: WeatherEntry {

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
