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

    var weatherScreenViewModel = WeatherScreenViewModel()

    var body: some Scene {
        WindowGroup {
            WeatherScreen(viewModel: weatherScreenViewModel)
        }
    }
}
