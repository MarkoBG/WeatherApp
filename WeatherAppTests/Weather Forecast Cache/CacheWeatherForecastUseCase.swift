//
//  CacheWeatherForecastUseCase.swift
//  WeatherAppTests
//
//  Created by Marko Tribl on 5/25/21.
//

import XCTest

class LocalWeatherLoader {
    init(store: WeatherForecastStore) {
        
    }
}

class WeatherForecastStore {
    var deleteCachedWeatherForecastCallCount = 0
}

class CacheWeatherForecastUseCase: XCTestCase {

    func test_init_doesNotDeleteCacheUponCreation() {
        let store = WeatherForecastStore()
        _ = LocalWeatherLoader(store: store)
        
        XCTAssertEqual(store.deleteCachedWeatherForecastCallCount, 0)
    }
}
