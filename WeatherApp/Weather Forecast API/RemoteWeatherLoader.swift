//
//  File.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

public final class RemoteWeatherLoader: WeatherLoader {
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = WeatherLoaderResult
        
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success(data, response):
                completion(WeatherForecastMapper.map(data, response: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}

