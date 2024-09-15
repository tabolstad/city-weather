//
//  WeatherScreen.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import SwiftUI

/// View that handles the layout of weather content and loading states.
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
                WeatherScreenLoadingView()
            case .loading:
                WeatherScreenLoadingView()
            case .finished:
                WeatherScreenContentView(viewModel: viewModel)
            case .error(let error):
                WeatherScreenErrorView()
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
    viewModel.state = .error(APIError.badRequest)
    return WeatherScreen(viewModel: viewModel)
}
