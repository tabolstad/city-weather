//
//  CityWeatherTests.swift
//  CityWeatherTests
//
//  Created by Timothy Bolstad on 9/13/24.
//

import Testing
@testable import CityWeather

struct OpenWeatherTests {

    @Test func testBuildingLocationStringWithState() async throws {
        let api = OpenWeather()
        let location = api.buildLocation(city: "Cleveland", state: "OH")
        #expect(location == "Cleveland,OH")
    }

    @Test func testBuildingLocationStringWithoutState() async throws {
        let api = OpenWeather()
        let location = api.buildLocation(city: "Cleveland", state: nil)
        #expect(location == "Cleveland")
    }
}
