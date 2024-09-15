//
//  WeatherScreen.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import SwiftUI

struct WeatherScreen: View {

    var viewModel: WeatherScreenViewModel

    internal init(viewModel: WeatherScreenViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 20)
            SearchViewRepresentable(delegate: viewModel)
                .frame(height: 44)
            switch viewModel.state {
            case .idle:
                Text("Idle")
            case .loading:
                ProgressView()
            case .finished:
                WeatherScreenContentView(viewModel: viewModel)
            case .error(let error):
                Text("Error \(error)")
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .task {
            //await viewModel.getWeather(search: "Paris")
        }
    }
}

struct WeatherScreenContentView: View {

    var viewModel: WeatherScreenViewModel

    internal init(viewModel: WeatherScreenViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            WeatherDetailView(viewModel: viewModel.contentViewModel)
                .frame(maxWidth: .infinity)
        }
        .background(Color.blue)
    }
}

#Preview {
    let viewModel = WeatherScreenViewModel()
    viewModel.state = .finished
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
