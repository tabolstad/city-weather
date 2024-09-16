//
//  WeatherScreenViewModelTests.swift
//  CityWeatherTests
//
//  Created by Timothy Bolstad on 9/15/24.
//

import Foundation

import Testing
@testable import CityWeather

struct WeatherScreenViewModelTests {

    @Test func testWeatherScreenLoadingStateBeginsIdle() async throws {

        let api = MockWeatherAPI.mock
        let viewModel = WeatherScreenViewModel(api: api)

        if case LoadingState.idle = viewModel.state {
            #expect(Bool(true))
        } else {
            #expect(Bool(false))
        }
    }

    @Test func testWeatherScreenLoadingStateSuccess() async throws {

        let api = MockWeatherAPI.mock
        let viewModel = WeatherScreenViewModel(api: api)
        await viewModel.getWeather(search: "Chicago")

        if case LoadingState.finished = viewModel.state {
            #expect(Bool(true))
        } else {
            #expect(Bool(false))
        }
    }

    @Test func testWeatherScreenLoadingStateError() async throws {

        let api = MockWeatherAPI.mock
        api.throwError = APIError.badRequest
        let viewModel = WeatherScreenViewModel(api: api)
        await viewModel.getWeather(search: "Chicago")

        if case LoadingState.error(APIError.badRequest) = viewModel.state {
            #expect(Bool(true))
        } else {
            #expect(Bool(false))
        }
    }

    @Test func testWeatherScreenLoadingStateInvalidKeyError() async throws {

        let api = MockWeatherAPI.mock
        api.throwError = APIError.invalidApiKey
        let viewModel = WeatherScreenViewModel(api: api)
        await viewModel.getWeather(search: "Chicago")

        if case LoadingState.error(APIError.invalidApiKey) = viewModel.state {
            #expect(Bool(true))
        } else {
            #expect(Bool(false))
        }
    }
}
