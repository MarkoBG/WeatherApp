//
//  WeatherLoader.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

public enum WeatherLoaderResult {
    case success(WeatherForecast)
    case failure(Error)
}

public protocol WeatherLoader {
    func load(completion: @escaping (WeatherLoaderResult) -> Void)
}
