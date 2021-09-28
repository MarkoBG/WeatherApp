//
//  LocalWeatherLoader.swift
//  WeatherApp
//
//  Created by Marko Tribl on 5/27/21.
//

import Foundation

public final class LocalWeatherLoader {
    private let store: WeatherForecastStore
    private let currentDate: () -> Date
    
    public typealias SaveResult = Error?
    
    public init(store: WeatherForecastStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
    
    public func save(_ forecast: WeatherForecast, completion: @escaping (SaveResult) -> Void) {
        store.deleteCachedWeatherForecast { [weak self] error in
            guard let self = self else { return }
            
            if let cacheDeletionError = error {
                completion(cacheDeletionError)
            } else {
                self.cache(forecast, with: completion)
            }
        }
    }
    
    private func cache(_ forecast: WeatherForecast, with completion: @escaping (SaveResult) -> Void) {
        store.insert(forecast.toLocal(), timestamp: currentDate()) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
    }
}

private extension WeatherForecast {
    func toLocal() -> LocalWeatherForecast {
        return LocalWeatherForecast(location: location, currentWeather: currentWeather, forecast: forecast)
    }
}
