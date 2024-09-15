//
//  WeatherScreenContent.swift
//  CityWeather
//
//  Created by Timothy Bolstad on 9/15/24.
//

import SwiftUI

struct WeatherScreenContentView: View {

    var viewModel: WeatherScreenViewModel

    internal init(viewModel: WeatherScreenViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            ViewThatFits {
                // Fits normally - no scrolling
                WeatherDetailView(viewModel: viewModel.contentViewModel)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)

                // Doesn't fit - add scrolling so keyboard does not push the textfield offscreen.
                ScrollView {
                    WeatherDetailView(viewModel: viewModel.contentViewModel)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
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
