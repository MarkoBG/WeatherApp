//
//  WeatherLoader.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

enum WeatherLoaderResult {
    case success(WeatherForecast)
    case failure(Error)
}

protocol WeatherLoader {
    func load(completion: @escaping (WeatherLoaderResult) -> Void)
}
