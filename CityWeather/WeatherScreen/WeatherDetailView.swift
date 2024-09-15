//
//  WeatherDetailView.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/13/24.
//

import SwiftUI

/// View to display the weather data
struct WeatherDetailView: View {

    let viewModel: WeatherDetailViewModel

    internal init(viewModel: WeatherDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.name)
                        .font(.title)
                        .bold()
                    DataPointView(label: "weather_detail_temp_label".localized, value: viewModel.temperature)
                    DataPointView(label: "weather_detail_high_temp_label".localized, value: viewModel.tempHigh)
                    DataPointView(label: "weather_detail_low_temp_label".localized, value: viewModel.tempLow)
                    DataPointView(label: "weather_detail_feels_like_temp_label".localized, value: viewModel.tempFeelsLike)
                    DataPointView(label: "weather_detail_pressure_label".localized, value: viewModel.pressure)
                    DataPointView(label: "weather_detail_humidity_label".localized, value: viewModel.humidity)
                    DataPointView(label: "weather_detail_wind_speed_label".localized, value: viewModel.windSpeed)
                    DataPointView(label: "weather_detail_wind_direction_label".localized, value: viewModel.windDirection)
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
                       default:
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

    /// Apply formatting to each weather data entry.
    struct DataPointView: View {

        let label: String
        let value: String

        var body: some View {

            HStack {
                Text("\(label): ")
                    .bold()
                Spacer()
                Text(value)
            }
        }
    }
}
