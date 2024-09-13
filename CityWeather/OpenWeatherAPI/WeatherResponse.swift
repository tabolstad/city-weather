//
//  WeatherResponse.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import Foundation

// Root structure
struct WeatherResponse: Decodable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

// Coordinates
struct Coord: Decodable {
    let lon: Double
    let lat: Double
}

// Weather details
struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// Main weather information
struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int
    let grnd_level: Int
}

// Wind details
struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

// Clouds information
struct Clouds: Decodable {
    let all: Int
}

// System information
struct Sys: Decodable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
