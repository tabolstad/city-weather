//
//  OpenWeather.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import Foundation

class OpenWeather {

    static let apiKey = ""
    static let geocodeSearchUrl = "https://api.openweathermap.org/data/2.5/weather"

    func getWeather(city: String, state: String?) async throws -> WeatherResponse {

        let urlSession = URLSession(configuration: .default)

        // Build Request
        var url = URL(safe: Self.geocodeSearchUrl)
        let location = buildLocation(city: city, state: state)
        let query = [
            URLQueryItem(name: "q", value: location),
            URLQueryItem(name: "appid", value: Self.apiKey),
            URLQueryItem(name: "units", value: "imperial")
        ]
        url.append(queryItems: query)

        // Send Request
        let (data, urlResponse) = try await urlSession.data(from: url)
        // Handle Response
        try handleResponse(urlResponse)
        // Decode Data
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(WeatherResponse.self, from: data)
        return decoded
    }

    func buildLocation(city: String, state: String?) -> String {
        var location = city
        if let state {
            location = city + "," + state
        }
        return location
    }

    func getWeather(longitude: Double, latitude: Double) async throws -> WeatherResponse {

        let urlSession = URLSession(configuration: .default)

        // Build Request
        var url = URL(safe: Self.geocodeSearchUrl)
        let query = [
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
            URLQueryItem(name: "units", value: "imperial")
        ]
        url.append(queryItems: query)

        // Send Request
        let (data, urlResponse) = try await urlSession.data(from: url)
        // Handle Response
        try handleResponse(urlResponse)
        // Decode Data
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(WeatherResponse.self, from: data)
        return decoded
    }

    private func handleResponse(_ urlResponse: URLResponse) throws {
        guard let response = urlResponse as? HTTPURLResponse else {
            throw APIError.unexpectedResponse
        }
        switch response.statusCode {
        case 200:
            break
        case 400:
            throw APIError.badRequest
        case 401:
            throw APIError.invalidApiKey
        case 404:
            throw APIError.notFound
        case 500, 502, 503, 504:
            throw APIError.serverError
        default:
            throw APIError.unexpectedResponse
        }
    }
}
