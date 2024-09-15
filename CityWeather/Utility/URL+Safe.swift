//
//  URL+Safe.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import Foundation

extension URL {
    init(safe: String) {
        guard let url = URL(string: safe) else {
            fatalError("Safe URL is misconfigured: \(safe)")
        }
        self = url
    }
}
