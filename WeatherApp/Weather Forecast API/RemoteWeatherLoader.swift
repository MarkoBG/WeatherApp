//
//  File.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

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
        client.get(from: url) { result in
            switch result {
            case let .success(data, response):
                do {
                    let weatherForecast = try WeatherForecastMapper.map(data, response)
                    completion(.success(weatherForecast))
                } catch {
                    completion(.failure(.invalidData))
                }
                
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}

private class WeatherForecastMapper {
    
    private static var OK_200: Int {
        return 200
    }
    
    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> WeatherForecast {
        guard response.statusCode == OK_200 else {
            throw RemoteWeatherLoader.Error.invalidData
        }
        
        let weatherForecast = try JSONDecoder().decode(WeatherForecast.self, from: data)
        return weatherForecast
    }
}
