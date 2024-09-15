//
//  WeatherAPI.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/15/24.
//

import Foundation

protocol WeatherAPI {
    func getWeather(city: String, state: String?) async throws -> WeatherResponse
    func getWeather(longitude: Double, latitude: Double) async throws -> WeatherResponse
}
