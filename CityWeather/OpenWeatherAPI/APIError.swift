//
//  APIError.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import Foundation

enum APIError: Error {
    case unexpectedResponse
    case badRequest
    case invalidApiKey
    case notFound
    case serverError
    case urlFetchingError
    case imageFetchingError
}
