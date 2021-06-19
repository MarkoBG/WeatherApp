//
//  WeatherForecastMapper.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/25/21.
//

import Foundation

internal final class WeatherForecastMapper {

    private static var OK_200: Int {
        return 200
    }
    
    internal static func map(_ data: Data, response: HTTPURLResponse) throws -> WeatherAPI {
        
        guard response.statusCode == OK_200, let weatherForecast = try? JSONDecoder().decode(WeatherAPI.self, from: data) else {
            throw RemoteWeatherLoader.Error.invalidData
        }
        
        return weatherForecast
    }
}
