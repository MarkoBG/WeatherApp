//
//  WeatherForecastStore.swift
//  WeatherApp
//
//  Created by Marko Tribl on 5/27/21.
//

import Foundation

public protocol WeatherForecastStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    func deleteCachedWeatherForecast(completion: @escaping DeletionCompletion)
    func insert(_ forecast: LocalWeatherForecast, timestamp: Date, completion: @escaping InsertionCompletion)
}


