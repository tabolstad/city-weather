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

    struct LoadingStates {
        @Test func loadingStateBeginsIdle() async throws {
            
            let api = MockWeatherAPI.mock
            let viewModel = WeatherScreenViewModel(api: api)
            
            if case LoadingState.idle = viewModel.state {
                #expect(Bool(true))
            } else {
                #expect(Bool(false))
            }
        }
        
        @Test func loadingStateSuccess() async throws {
            
            let api = MockWeatherAPI.mock
            let viewModel = WeatherScreenViewModel(api: api)
            await viewModel.getWeather(search: "Chicago")
            
            if case LoadingState.finished = viewModel.state {
                #expect(Bool(true))
            } else {
                #expect(Bool(false))
            }
        }
        
        @Test func loadingStateError() async throws {
            
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
        
        @Test func loadingStateInvalidKeyError() async throws {
            
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
}
