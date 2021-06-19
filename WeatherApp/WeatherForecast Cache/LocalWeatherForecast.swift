//
//  LocalWeatherForecast.swift
//  WeatherApp
//
//  Created by Marko Tribl on 6/19/21.
//

import Foundation

public struct LocalWeatherForecast: Equatable {
    public let location: Location
    public let currentWeather: CurrentWeather
    public let forecast: Forecast
    
    public init(location: Location, currentWeather: CurrentWeather, forecast: Forecast) {
        self.location = location
        self.currentWeather = currentWeather
        self.forecast = forecast
    }
    
    public static func == (lhs: LocalWeatherForecast, rhs: LocalWeatherForecast) -> Bool {
        return lhs.location.localTime == rhs.location.localTime
    }
}
