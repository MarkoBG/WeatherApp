//
//  WeatherAppAPIEndToEndTests.swift
//  WeatherAppAPIEndToEndTests
//
//  Created by Marko Tribl on 3/30/21.
//

import XCTest
import WeatherApp

class WeatherAppAPIEndToEndTests: XCTestCase {

    func test_endToEndTestServer_getWeatherForecastLocation() {
        
        switch getWeaterResult() {
        case let . success(weatherForecast):
            let location = weatherForecast.location
            XCTAssertEqual(location.name, "Belgrade")
            XCTAssertEqual(location.country, "Serbia")
        case let .failure(error):
            XCTFail("Expected successful result got error \(error) instead")
        default:
            XCTFail("Expected successful result got no result instead")
        }
    }
    
    // MARK: - Helpers
    func getWeaterResult() -> WeatherLoaderResult? {
        let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=89aefa75d6a545ce865222351210103&q=Belgrade&days=1&aqi=yes&alerts=no")!
        let client = URLSessionHTTPClient()
        let loader = RemoteWeatherLoader(url: url, client: client)
        
        let exp = expectation(description: "Wait for load completion")
        
        var receivedResult: WeatherLoaderResult?
        
        loader.load { result in
            receivedResult = result
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5.0)
        
        return receivedResult
    }

}
