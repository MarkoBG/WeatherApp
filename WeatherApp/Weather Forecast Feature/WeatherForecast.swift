//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

public struct WeatherForecast: Equatable {
    public let location: Location
    public let currentWeather: CurrentWeather
    public let forecast: Forecast
    
    public init(location: Location, currentWeather: CurrentWeather, forecast: Forecast) {
        self.location = location
        self.currentWeather = currentWeather
        self.forecast = forecast
    }
    
    public static func == (lhs: WeatherForecast, rhs: WeatherForecast) -> Bool {
        return lhs.location.localTime == rhs.location.localTime
    }
}

public struct Forecast {
    public let days: [DailyWeatherForecast]
    
    public init(days: [DailyWeatherForecast]) {
        self.days = days
    }
}
