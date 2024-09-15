//
//  WeatherDetailView.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import SwiftUI

struct WeatherDetailView: View {

    let viewModel: WeatherContentViewModel

    internal init(viewModel: WeatherContentViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("City: \(viewModel.name)")
                Text("Temperature: \(viewModel.temperature)")
                Text("High: \(viewModel.tempHigh)")
                Text("Low: \(viewModel.tempLow)")
                Text("Feels Like: \(viewModel.tempFeelsLike)")
                Spacer()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.red)
        .padding([.leading, .trailing], 0)
        .padding([.top, .bottom])
    }
}
