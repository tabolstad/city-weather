//
//  UserData.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/15/24.
//

import Foundation

protocol UserDataProtocol {
    var enableLocation: Bool { get set }
    func getLastSearch() -> String?
    func saveLastSeach(_ search: String?)
}

class UserData: UserDataProtocol {

    internal init() {
        if UserDefaults.standard.value(forKey: Self.enableLocationKey) == nil {
            enableLocation = true
        } else {
            self.enableLocation = UserDefaults.standard.bool(forKey: Self.enableLocationKey)
        }
    }
    

    var enableLocation: Bool {
        didSet {
            UserDefaults.standard.set(enableLocation, forKey: Self.enableLocationKey)
        }
    }

    // We might not want to save a user string in plain text here.
    private static let lastSearchKey = "LastSearchString"
    private static let enableLocationKey = "EnableLocation"

    func getLastSearch() -> String? {
        return UserDefaults.standard.string(forKey: Self.lastSearchKey)
    }

    func saveLastSeach(_ search: String?) {
        UserDefaults.standard.set(search, forKey: Self.lastSearchKey)
    }
}
