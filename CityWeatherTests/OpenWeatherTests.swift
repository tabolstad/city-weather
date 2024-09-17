//
//  CityWeatherTests.swift
//  CityWeatherTests
//
//  Created by Timothy Bolstad on 9/13/24.
//

import Testing
@testable import CityWeather

struct OpenWeatherTests {

    @Test func buildLocationStringWithState() async throws {
        let api = OpenWeather()
        let location = api.buildLocation(city: "Cleveland", state: "OH")
        #expect(location == "Cleveland,OH")
    }

    @Test func buildLocationStringWithoutState() async throws {
        let api = OpenWeather()
        let location = api.buildLocation(city: "Cleveland", state: nil)
        #expect(location == "Cleveland")
    }
}
