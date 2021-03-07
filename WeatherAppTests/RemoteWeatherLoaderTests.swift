//
//  RemoteWeatherLoaderTests.swift
//  WeatherAppTests
//
//  Created by Marko Tribl on 3/7/21.
//

import XCTest

class RemoteWeatherLoader {
    
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() {
        
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

class RemoteWeatherLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        _ = RemoteWeatherLoader(client: client)
        
        XCTAssertNil(client.requestedURL)
    }
    
    // MARK: - Helpers
    
    private class HTTPClientSpy: HTTPClient {
        
        var requestedURL: URL?
        
        func get(from url: URL) {
            requestedURL = url
        }
    }
}
