//
//  WeatherDetailView.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import SwiftUI

struct WeatherDetailView: View {

    let viewModel: WeatherDetailViewModel

    internal init(viewModel: WeatherDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("City: \(viewModel.name)")
            Text("Temperature: \(viewModel.temperature)")
            Text("High: \(viewModel.tempHigh)")
            Text("Low: \(viewModel.tempLow)")
            Text("Feels Like: \(viewModel.tempFeelsLike)")
            Spacer()
        }
        .padding()
    }
}
