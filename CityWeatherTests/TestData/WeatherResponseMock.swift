//
//  WeatherResponseMock.swift
//  CityWeatherTests
//
//  Created by Timothy Bolstad on 9/15/24.
//

@testable import CityWeather

extension WeatherResponse {

    static var mock: WeatherResponse {

        let coord = Coord(lon: -81.6954, lat: 41.4995)

        let weather = Weather(
            id: 800,
            main: "Clear",
            description: "clear sky",
            icon: "01d"
        )

        let main = Main(
            temp: 82.81,
            feels_like: 83.17,
            temp_min: 80.32,
            temp_max: 84.6,
            pressure: 1024,
            humidity: 47,
            sea_level: 1024,
            grnd_level: 999
        )

        let wind = Wind(speed: 1.01, deg: 139, gust: 7)

        let sys = Sys(type: 2,
                      id: 2016542,
                      country: "US",
                      sunrise: 1726398459,
                      sunset: 1726443372)

        let response = WeatherResponse(
            coord: coord,
            weather: [weather],
            base: "stations",
            main: main,
            visibility: 10000,
            wind: wind,
            clouds: Clouds(all: 0),
            dt: 1726419668,
            sys: sys,
            timezone: -14400,
            id: 5150529,
            name: "Cleveland",
            cod: 200
        )
        return response
    }
}
