//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

struct WeatherForecast {
    let location: Location
    let currentWeather: CurrentWeather
    let days: [DailyWeatherForecast]
}
