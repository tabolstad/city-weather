//
//  CityWeatherApp.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import SwiftUI

@main
struct CityWeatherApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var launchManager: LaunchManager
    var userData: UserData
    var weatherScreenViewModel: WeatherScreenViewModel

    init() {
        let userData = UserData()
        let viewModel = WeatherScreenViewModel(userData: userData)
        let launchManager = LaunchManager(userData: userData, weatherScreenViewModel: viewModel)
        self.userData = userData
        self.launchManager = launchManager
        self.weatherScreenViewModel = viewModel
        appDelegate.launchManager = launchManager
    }

    var body: some Scene {
        WindowGroup {
            WeatherScreen(viewModel: weatherScreenViewModel)
        }
    }
}
