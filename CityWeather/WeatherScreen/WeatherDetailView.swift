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
        VStack(alignment: .leading) {
            HStack {
                VStack {
                    Text("City: \(viewModel.name)")
                    Text("Temperature: \(viewModel.temperature)")
                    Text("High: \(viewModel.tempHigh)")
                    Text("Low: \(viewModel.tempLow)")
                    Text("Feels Like: \(viewModel.tempFeelsLike)")
                }
                // AsyncImage and it's default cache should be sufficient for
                // this simple use case. If more cache flexibility is needed
                // or a more high performance scroll view is used, a library
                // such as SDWebImage might be a better choice.
                HStack {
                    Spacer()
                    AsyncImage(url: viewModel.weatherIcon) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                        case .failure(let error):
                            Image(systemName: "sun.max.trianglebadge.exclamationmark.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                        }
                    }
                    Spacer()
                }
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
