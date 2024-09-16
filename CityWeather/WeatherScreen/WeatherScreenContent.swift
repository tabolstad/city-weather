//
//  WeatherScreenContent.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/15/24.
//

import SwiftUI

struct WeatherScreenContentView: View {

    var viewModel: WeatherScreenViewModel
    @Binding var enableLocation: Bool

    internal init(viewModel: WeatherScreenViewModel, enableLocation: Binding<Bool>) {
        self.viewModel = viewModel
        self._enableLocation = enableLocation
    }

    var body: some View {
        VStack(alignment: .leading) {
            ViewThatFits {
                // Fits normally - no scrolling
                VStack {
                    WeatherDetailView(viewModel: viewModel.detailViewModel)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
                    Toggle("enable_location_toggle".localized, isOn: $enableLocation)
                        .tint(Color.accentColor)
                }

                // Doesn't fit - add scrolling so keyboard does not push the textfield offscreen.
                ScrollView {
                    VStack {
                        WeatherDetailView(viewModel: viewModel.detailViewModel)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(12)
                            .frame(maxWidth: .infinity)
                        Toggle("enable_location_toggle".localized, isOn: $enableLocation)
                            .tint(Color.accentColor)
                    }
                }
            }
        }
    }
}

struct WeatherScreenLoadingView: View {

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            HStack {
                Spacer()
                ProgressView()
                Spacer()
            }
            Spacer()
        }
    }
}

struct WeatherScreenErrorView: View {

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            HStack {
                Image(systemName: "sun.max.trianglebadge.exclamationmark.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                Text("weather_screen_error_label".localized)
                    .font(.title)
                    .multilineTextAlignment(.center)

                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}

struct WeatherScreenIdleView: View {

    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                Spacer()
                Image(systemName: "sun.max")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                Text("weather_screen_idle_label".localized)
                    .font(.title)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}
