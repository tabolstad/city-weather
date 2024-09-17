//
//  WeatherResponseTests.swift
//  CityWeatherTests
//
//  Created by Timothy Bolstad on 9/15/24.
//

import Foundation

import Testing
@testable import CityWeather

struct WeatherEntryTests {

    @Test func initializationFromResponse() async throws {

        let response: WeatherResponse = try TestData.json("weather_response")
        let entry = WeatherEntry(response: response)

        #expect(entry.id == 4525353)
        #expect(entry.name == "Springfield")
        #expect(entry.coordinates.longitude == -83.8088)
        #expect(entry.coordinates.latitude == 39.9242)
        #expect(entry.weatherIcon == "https://openweathermap.org/img/wn/02d@2x.png")

        #expect(entry.temperature == 302.56)
        #expect(entry.tempFeelsLike == 302.18)
        #expect(entry.tempMin == 301.75)
        #expect(entry.tempMax == 303.88)
        #expect(entry.pressure == 1016)
        #expect(entry.humidity == 40)
        #expect(entry.windSpeed == 4.12)
        #expect(entry.windDirection == 130)
    }
}
