//
//  WeatherResponseTests.swift
//  CityWeatherTests
//
//  Created by Timothy Bolstad on 9/13/24.
//

import Foundation

import Testing
@testable import CityWeather

struct WeatherResponseTests {

    @Test func decoding() async throws {

        let response: WeatherResponse = try TestData.json("weather_response")

        #expect(response.id == 4525353)
        #expect(response.name == "Springfield")
        #expect(response.visibility == 10000)

        let coord = response.coord
        #expect(coord.lon == -83.8088)
        #expect(coord.lat == 39.9242)

        let weather = try #require(response.weather.first)
        #expect(weather.id == 801)
        #expect(weather.main == "Clouds")
        #expect(weather.description == "few clouds")
        #expect(weather.icon == "02d")

        let main = response.main
        #expect(main.temp == 302.56)
        #expect(main.feels_like == 302.18)
        #expect(main.temp_min == 301.75)
        #expect(main.temp_max == 303.88)
        #expect(main.pressure == 1016)
        #expect(main.humidity == 40)
        #expect(main.sea_level == 1016)
        #expect(main.grnd_level == 980)

        let wind = response.wind
        #expect(wind.speed == 4.12)
        #expect(wind.deg == 130)

        let clouds = response.clouds
        #expect(clouds.all == 20)

        let sys = response.sys
        #expect(sys.sunrise == 1726226093)
        #expect(sys.sunset == 1726271240)
    }
}
