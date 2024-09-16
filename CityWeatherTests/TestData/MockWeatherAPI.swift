//
//  MockWeatherAPI.swift
//  CityWeatherTests
//
//  Created by Timothy Bolstad on 9/15/24.
//

import Foundation
@testable import CityWeather

class MockWeatherAPI: WeatherAPI {

    var response = WeatherResponse.mock
    var throwError: Error?

    func getWeather(city: String, state: String?) async throws -> WeatherResponse {

        if let throwError {
            throw throwError
        }
        return response
    }

    func getWeather(longitude: Double, latitude: Double) async throws -> WeatherResponse {

        if let throwError {
            throw throwError
        }
        return response
    }
}

extension MockWeatherAPI {
    static var mock: MockWeatherAPI {
        let api = MockWeatherAPI()
        let testResponse: WeatherResponse? = try? TestData.json("weather_response")
        guard let testResponse else {
            fatalError("Error creating test response data.")
        }
        api.response = testResponse
        return api
    }
}
