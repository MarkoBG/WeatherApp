//
//  File.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

public final class RemoteWeatherLoader {
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public enum Result: Equatable {
        case success(WeatherForecast)
        case failure(Error)
    }
        
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            switch result {
            case let .success(data, response):
                completion((self?.map(data, response: response))!)
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
    
    private func map(_ data: Data, response: HTTPURLResponse) -> Result {
        do {
            let weatherForecast = try WeatherForecastMapper.map(data, response)
            return .success(weatherForecast)
        } catch {
            return .failure(.invalidData)
        }
    }
}

