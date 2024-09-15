//
//  String+Localized.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/14/24.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }

    func localized(_ value: String) -> String {
        let format = NSLocalizedString(self, comment: "")
        return String.localizedStringWithFormat(format, value)
    }
}
