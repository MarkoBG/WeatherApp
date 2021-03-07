//
//  RemoteWeatherLoaderTests.swift
//  WeatherAppTests
//
//  Created by Marko Tribl on 3/7/21.
//

import XCTest

class RemoteWeatherLoader {
    
    private let url: URL
    private let client: HTTPClient
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load() {
        client.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

class RemoteWeatherLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let url = URL(string: "https://any-url.com")!
        let client = HTTPClientSpy()
        _ = RemoteWeatherLoader(url: url, client: client)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "https://any-url.com")!
        let client = HTTPClientSpy()
        let sut = RemoteWeatherLoader(url: url, client: client)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
    }
    
    // MARK: - Helpers
    
    private class HTTPClientSpy: HTTPClient {
        
        var requestedURL: URL?
        
        func get(from url: URL) {
            requestedURL = url
        }
    }
}
