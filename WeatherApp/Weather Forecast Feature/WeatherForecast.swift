//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

public struct WeatherForecast: Equatable {
    let location: Location
    let currentWeather: CurrentWeather
    let days: [DailyWeatherForecast]
    
    public static func == (lhs: WeatherForecast, rhs: WeatherForecast) -> Bool {
        return lhs.location.localTime == rhs.location.localTime
    }
}
