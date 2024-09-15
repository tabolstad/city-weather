//
//  UserData.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/15/24.
//

import Foundation

protocol UserDataProtocol {
    func getLastSearch() -> String?
    func saveLastSeach(_ search: String?)
}

class UserData: UserDataProtocol {

    // We might not want to save a user string in plain text here.
    private static let lastSearchKey = "LastSearchString"

    func getLastSearch() -> String? {
        return UserDefaults.standard.string(forKey: Self.lastSearchKey)
    }

    func saveLastSeach(_ search: String?) {
        UserDefaults.standard.set(search, forKey: Self.lastSearchKey)
    }
}
