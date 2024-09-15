//
//  WeatherDetailViewModelTests.swift
//  CityWeatherTests
//
//  Created by Timothy Bolstad on 9/15/24.
//

import Foundation

import Testing
@testable import CityWeather

struct WeatherDetailViewModelTests {

    @Test func testWeatherViewModelData() async throws {

        let response: WeatherResponse = try TestData.json("weather_response")
        let entry = WeatherEntry(response: response)
        let viewModel = WeatherDetailViewModel(weather: entry)

        #expect(viewModel.name == "Springfield")
        #expect(viewModel.temperature == "303℉")
        #expect(viewModel.tempFeelsLike == "302℉")
        #expect(viewModel.tempLow == "302℉")
        #expect(viewModel.tempHigh == "304℉")
        #expect(viewModel.humidity == "40%")
        #expect(viewModel.pressure == "1016 hPa")
        #expect(viewModel.windSpeed == "4 mph")
        #expect(viewModel.windDirection == "130°")
        #expect(viewModel.weatherIcon == URL(string: "https://openweathermap.org/img/wn/02d@2x.png"))
    }
}
