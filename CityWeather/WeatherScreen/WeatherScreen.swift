//
//  WeatherScreen.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import SwiftUI

struct WeatherScreen: View {

    let viewModel: WeatherScreenViewModel

    internal init(viewModel: WeatherScreenViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {

        Group {
            switch viewModel.state {
            case .idle:
                Text("Idle")
            case .loading:
                Text("Loading")
            case .finished(let value):
                VStack {
                    WeatherDetailView(viewModel: WeatherDetailViewModel(weather: value))
                        .background(Color.red)
                }
            case .error(let error):
                Text("Error \(error)")
            }
        }
        .task {
            await viewModel.getWeather()
        }
    }

}

#Preview {
    let viewModel = WeatherScreenViewModel()
    viewModel.state = .finished(WeatherEntry.mock)
    return WeatherScreen(viewModel: viewModel)
}

#Preview("Loading") {
    let viewModel = WeatherScreenViewModel()
    viewModel.state = .loading
    return WeatherScreen(viewModel: viewModel)
}

#Preview("Idle") {
    let viewModel = WeatherScreenViewModel()
    viewModel.state = .idle
    return WeatherScreen(viewModel: viewModel)
}
