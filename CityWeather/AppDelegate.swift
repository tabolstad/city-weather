//
//  AppDelegate.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/15/24.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {

    var launchManager: LaunchManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        launchManager?.beginAppLaunch()
        return true
    }
}
