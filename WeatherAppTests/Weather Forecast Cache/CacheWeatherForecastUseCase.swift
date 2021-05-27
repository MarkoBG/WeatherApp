//
//  CacheWeatherForecastUseCase.swift
//  WeatherAppTests
//
//  Created by Marko Tribl on 5/25/21.
//

import XCTest
import WeatherApp

class LocalWeatherLoader {
    private let store: WeatherForecastStore
    private let currentDate: () -> Date
    
    init(store: WeatherForecastStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
    
    func save(_ forecast: WeatherForecast, completion: @escaping (Error?) -> Void) {
        store.deleteCachedWeatherForecast { [weak self] error in
            guard let self = self else { return }
            
            if error == nil {
                self.store.insert(forecast, timestamp: self.currentDate(), completion: completion)
            } else {
                completion(error)
            }
        }
    }
}

protocol WeatherForecastStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    func deleteCachedWeatherForecast(completion: @escaping DeletionCompletion)
    func insert(_ forecast: WeatherForecast, timestamp: Date, completion: @escaping InsertionCompletion)
}

class CacheWeatherForecastUseCase: XCTestCase {

    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_save_requestsCacheDeletion() {
        let (sut, store) = makeSUT()
        
        let weatherForecast = createWeatherForecast(location: createWeatherLocation().model, currentWeather: createCurrentWeather(condition: createWeatherCondition().model, airQuality: createAirQuality().model).model, forecast: createForecast().model)
        
        sut.save(weatherForecast.model) { _ in }
        XCTAssertEqual(store.receivedMessages, [.deleteCachedWeatherForecast])
    }
    
    func test_save_doesNotRequestCacheInsertionOnDeletionError() {
        let (sut, store) = makeSUT()
        let deletionError = anyNSError()
        
        expect(sut, toCompleteWithError: deletionError) {
            store.completeDeletion(with: deletionError)
        }
    }
    
    func test_save_requestsNewCacheInsertionWithTimestampOnSuccessfulDeletion() {
        let timestamp = Date()
        let (sut, store) = makeSUT(currentDate: { timestamp })
        
        let weatherForecast = createWeatherForecast(location: createWeatherLocation().model, currentWeather: createCurrentWeather(condition: createWeatherCondition().model, airQuality: createAirQuality().model).model, forecast: createForecast().model)
        
        sut.save(weatherForecast.model) { _ in }
        store.completeDeletionSuccessfully()
        
        XCTAssertEqual(store.receivedMessages, [.deleteCachedWeatherForecast, .insert(weatherForecast.model, timestamp)])
    }
    
    func test_save_failsOnDeletionError() {
        let (sut, store) = makeSUT()
        let deletionError = anyNSError()
        
        expect(sut, toCompleteWithError: deletionError) {
            store.completeDeletion(with: deletionError)
        }
    }
    
    func test_save_failsOnInsertionError() {
        let (sut, store) = makeSUT()
        let insertionError = anyNSError()
        
        expect(sut, toCompleteWithError: insertionError) {
            store.completeDeletionSuccessfully()
            store.completeInsertion(with: insertionError)
        }
    }
    
    func test_save_succeedsOnSuccessfulCacheInsertion() {
        let (sut, store) = makeSUT()
        
        expect(sut, toCompleteWithError: nil) {
            store.completeDeletionSuccessfully()
            store.completeInsertionSuccessfully()
        }
    }
    
    func test_save_doesNotDeliveryDelitionErrorAfterSUTHasBeenDeallocated() {
        let store = WeatherForecastStoreSpy()
        var sut: LocalWeatherLoader? = LocalWeatherLoader(store: store, currentDate: Date.init)
        let weatherForecast = createWeatherForecast(location: createWeatherLocation().model, currentWeather: createCurrentWeather(condition: createWeatherCondition().model, airQuality: createAirQuality().model).model, forecast: createForecast().model)
        var receivedResuts = [Error?]()
        
        sut?.save(weatherForecast.model) { receivedResuts.append($0) }
        
        sut = nil
        store.completeDeletion(with: anyNSError())
        
        XCTAssertTrue(receivedResuts.isEmpty)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalWeatherLoader, store: WeatherForecastStoreSpy) {
        let store = WeatherForecastStoreSpy()
        let sut = LocalWeatherLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(store, file: file, line: line)
        return (sut, store)
    }
    
    private func expect(_ sut: LocalWeatherLoader, toCompleteWithError expectedError: NSError?, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let weatherForecast = createWeatherForecast(location: createWeatherLocation().model, currentWeather: createCurrentWeather(condition: createWeatherCondition().model, airQuality: createAirQuality().model).model, forecast: createForecast().model)
        
        let exp = expectation(description: "Wait for save completion")
        
        var receivedError: Error?
        sut.save(weatherForecast.model) { error in
            receivedError = error
            exp.fulfill()
        }
        
        action()
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertEqual(receivedError as NSError?, expectedError, file: file, line: line)
    }
    
    private class WeatherForecastStoreSpy: WeatherForecastStore {
        enum ReceiveMessage: Equatable {
            case deleteCachedWeatherForecast
            case insert(WeatherForecast, Date)
        }
        
        private(set) var receivedMessages = [ReceiveMessage]()
        private var deletionCompletions = [DeletionCompletion]()
        private var insertionCompletions = [InsertionCompletion]()
        
        
        func deleteCachedWeatherForecast(completion: @escaping DeletionCompletion) {
            deletionCompletions.append(completion)
            receivedMessages.append(.deleteCachedWeatherForecast)
        }
        
        func completeDeletion(with error: Error, at index: Int = 0) {
            deletionCompletions[index](error)
        }
        
        func completeInsertion(with error: Error, at index: Int = 0) {
            insertionCompletions[index](error)
        }
        
        
        func completeDeletionSuccessfully(at index: Int = 0) {
            deletionCompletions[index](nil)
        }
        
        func completeInsertionSuccessfully(at index: Int = 0) {
            insertionCompletions[index](nil)
        }
        
        func insert(_ forecast: WeatherForecast, timestamp: Date, completion: @escaping InsertionCompletion) {
            insertionCompletions.append(completion)
            receivedMessages.append(.insert(forecast, timestamp))
        }
    }
    
    private func anyNSError() -> NSError {
        return NSError(domain: "Error", code: 1)
    }
    
    private func createWeatherLocation(name: String = "Belgrade", region: String = "Central Serbia", country: String = "Serbia", latitude: Double = 44.8, longitude: Double = 20.47, timeZoneId: String = "Europe/Belgrade", localTime: String = "2021-03-14 16:52") -> (model: Location, json: [String: Any]) {
        
        let location = Location(name: name, region: region, country: country, latitude: latitude, longitude: longitude, timeZoneId: timeZoneId, localTime: localTime)
        
        let json: [String: Any] = [
            "name": name,
            "region": region,
            "country": country,
            "lat": latitude,
            "lon": longitude,
            "tz_id": timeZoneId,
            "localtime": localTime
        ]
        
        return (location, json)
    }
    
    private func createCurrentWeather(lastUpdated: String = "2021-03-14 16:45", tempCelsius: Double = 14, tempFahrenheit: Double = 57.2, isDay: Int = 1, condition: WeatherCondition, windMph: Double = 4.3, windKph: Double = 6.8, windDegree: Int = 20, windDirection: String = "NNE", pressureMb: Double = 1004, pressureIn: Double = 30.1, precipitationMM: Double = 0, precipitationIN: Double = 0, humidity: Int = 63, cloud: Int = 50, feelslikeCelsius: Double = 13.4, feelslikeFahrenheit: Double = 56.1, visibilityKM: Double = 10, visibilityMiles: Double = 6, uvIndex: Double = 5, airQuality: AirQuality) -> (model: CurrentWeather, json: [String: Any]) {
        
        let currentWeather = CurrentWeather(lastUpdated: lastUpdated, tempCelsius: tempCelsius, tempFahrenheit: tempFahrenheit, isDay: isDay, condition: condition, windMph:windMph, windKph: windKph, windDegree: windDegree, windDirection: windDirection, pressureMb: pressureMb, pressureIn: pressureIn, precipitationMM: precipitationMM, precipitationIN: precipitationIN, humidity: humidity, cloud: cloud, feelslikeCelsius: feelslikeCelsius, feelslikeFahrenheit: feelslikeFahrenheit, visibilityKM: visibilityKM, visibilityMiles: visibilityMiles, uvIndex: uvIndex, airQuality: airQuality)
        
        let json: [String: Any] = [
            "last_updated": lastUpdated,
            "temp_c": tempCelsius,
            "temp_f": tempFahrenheit,
            "is_day": isDay,
            "condition": createWeatherCondition().json,
            "wind_mph": windMph,
            "wind_kph": windKph,
            "wind_degree": windDegree,
            "wind_dir": windDirection,
            "pressure_mb": pressureMb,
            "pressure_in": pressureIn,
            "precip_mm": precipitationMM,
            "precip_in": precipitationIN,
            "humidity": humidity,
            "cloud": cloud,
            "feelslike_c": feelslikeCelsius,
            "feelslike_f": feelslikeFahrenheit,
            "vis_km": visibilityKM,
            "vis_miles": visibilityMiles,
            "uv": uvIndex,
            "air_quality": createAirQuality().json
        ]
        
        return (currentWeather, json)
    }
    
    private func createWeatherCondition(description: String = "Partly cloudy", iconURL: String = "//cdn.weatherapi.com/weather/64x64/day/116.png", code: Int = 1003) -> (model: WeatherCondition, json: [String: Any]) {
        
        let weatherCondition = WeatherCondition(description: description, iconURL: iconURL, code: code)
        
        let json: [String: Any] = [
            "text": description,
            "icon": iconURL,
            "code": code
        ]
        
        return (weatherCondition, json)
    }
    
    private func createAirQuality(carbonMonoxide: Double = 220.3000030517578, ozon: Double = 91.5999984741211, nitrogenDioxide: Double = 1.7000000476837158, sulphurDioxide: Double = 3.5, pm2_5: Double = 2.200000047683716, pm10: Double = 3.200000047683716, usEpaIndex: Int = 1, gbDefraIndex: Int = 1) -> (model: AirQuality, json: [String: Any]) {
        
        let airQuality = AirQuality(carbonMonoxide: carbonMonoxide, ozon: ozon, nitrogenDioxide: nitrogenDioxide, sulphurDioxide: sulphurDioxide, pm2_5: pm2_5, pm10: pm10, usEpaIndex: usEpaIndex, gbDefraIndex: gbDefraIndex)
        
        let json: [String: Any] = [
            "co": carbonMonoxide,
            "no2": nitrogenDioxide,
            "o3": ozon,
            "so2": sulphurDioxide,
            "pm2_5": pm2_5,
            "pm10": pm10,
            "us-epa-index": usEpaIndex,
            "gb-defra-index": gbDefraIndex
        ]
        
        return (airQuality, json)
    }
    
    private func createForecast(days: [DailyWeatherForecast] = []) -> (model: Forecast, json: [String: Any]) {
        let forecast = Forecast(days: days)
        let json: [String: Any] = ["forecastday": days]
        return (forecast, json)
    }
    
    private func createWeatherForecast(location: Location, currentWeather: CurrentWeather, forecast: Forecast) -> (model: WeatherForecast, json: [String: Any]) {
        
        let weatherForecast = WeatherForecast(location: location, currentWeather: currentWeather, forecast: forecast)
        
        let condition = createWeatherCondition()
        let airQuality = createAirQuality()
        let currentWeather = createCurrentWeather(condition: condition.model, airQuality: airQuality.model)
        
        let json: [String: Any] = [
            "location": createWeatherLocation().json,
            "current": currentWeather.json,
            "forecast": createForecast().json
        ]
        
        return (weatherForecast, json)
    }
}
