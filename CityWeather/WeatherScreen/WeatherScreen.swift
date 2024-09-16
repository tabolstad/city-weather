//
//  WeatherScreen.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import SwiftUI

/// View that handles the layout of weather content and loading states.
struct WeatherScreen: View {

    @Bindable var viewModel: WeatherScreenViewModel

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
                WeatherScreenIdleView()
            case .loading:
                WeatherScreenLoadingView()
            case .finished:
                WeatherScreenContentView(viewModel: viewModel, enableLocation: $viewModel.enableLocation)
            case .error(let error):
                WeatherScreenErrorView(error: error)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
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

#Preview("Error") {
    let viewModel = WeatherScreenViewModel()
    viewModel.state = .error(APIError.badRequest)
    return WeatherScreen(viewModel: viewModel)
}

#Preview("Idle") {
    let viewModel = WeatherScreenViewModel()
    viewModel.state = .idle
    return WeatherScreen(viewModel: viewModel)
}
