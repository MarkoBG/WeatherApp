//
//  RemoteWeatherLoaderTests.swift
//  WeatherAppTests
//
//  Created by Marko Tribl on 3/7/21.
//

import XCTest
import WeatherApp

class RemoteWeatherLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let (client, _) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (client, sut) = makeSUT(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (client, sut) = makeSUT(url: url)
        
        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (client, sut) = makeSUT()
        
        expect(sut, toCompleteWith: .failure(.connectivity)) {
            let clientError = NSError(domain: "Test", code: 0, userInfo: nil)
            client.complete(with: clientError)
        }
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (client, sut) = makeSUT()
        
        let samples = [199, 201, 300, 400, 401, 403, 500]
        
        samples.enumerated().forEach { index, code in
            
            expect(sut, toCompleteWith: .failure(.invalidData)) {
                let emptyJSONData = Data.init("{}".utf8)
                client.complete(withStatusCode: 400, data: emptyJSONData, at: index)
            }
        }
    }
    
    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (client, sut) = makeSUT()
        
        expect(sut, toCompleteWith: .failure(.invalidData)) {
            let invalidJSON = Data.init("invalid json".utf8)
            client.complete(withStatusCode: 400, data: invalidJSON)
        }
    }
    
    func test_load_deliversWeatherForecastOn200HTTPResponseWithValidJSON() {
        let (client, sut) = makeSUT()
        let location = createWeatherLocation()
        let condition = createWeatherCondition()
        let airQuality = createAirQuality()
        let current = createCurrentWeather(condition: condition.model, airQuality: airQuality.model)
        let forecast = createForecast()
        let weatherForecast = createWeatherForecast(location: location.model, currentWeather: current.model, forecast: forecast.model)
        
        expect(sut, toCompleteWith: .success(weatherForecast.model)) {
            let data = try! JSONSerialization.data(withJSONObject: weatherForecast.json)
            client.complete(withStatusCode: 200, data: data)
        }
    }
    
    // MARK: - Helpers
    
    private class HTTPClientSpy: HTTPClient {
        
        var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()
        
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
            let response = HTTPURLResponse(url: requestedURLs[index], statusCode: code, httpVersion: nil, headerFields: nil)!
            
            messages[index].completion(.success(data, response))
        }
    }
    
    private func makeSUT(url: URL = URL(string: "https://any-url.com")!) -> (client: HTTPClientSpy, sut: RemoteWeatherLoader) {
        let client = HTTPClientSpy()
        let sut = RemoteWeatherLoader(url: url, client: client)
        return (client, sut)
    }
    
    private func expect(_ sut: RemoteWeatherLoader, toCompleteWith result: RemoteWeatherLoader.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        
        var capturedResults = [RemoteWeatherLoader.Result]()
        sut.load { capturedResults.append($0) }
        
        action()
        
        XCTAssertEqual(capturedResults, [result], file: file, line: line)
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
    
    private func createCurrentWeather(lastUpdated: String = "2021-03-14 16:45", tempCelsius: Float = 14, tempFahrenheit: Float = 57.2, isDay: Int = 1, condition: WeatherCondition, windMph: Float = 4.3, windKph: Float = 6.8, windDegree: Int = 20, windDirection: String = "NNE", pressureMb: Float = 1004, pressureIn: Float = 30.1, precipitationMM: Float = 0, precipitationIN: Float = 0, humidity: Int = 63, cloud: Int = 50, feelslikeCelsius: Float = 13.4, feelslikeFahrenheit: Float = 56.1, visibilityKM: Float = 10, visibilityMiles: Float = 6, uvIndex: Float = 5, airQuality: AirQuality) -> (model: CurrentWeather, json: [String: Any]) {
        
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
    
    private func createAirQuality(carbonMonoxide: Float = 220.3000030517578, ozon: Float = 91.5999984741211, nitrogenDioxide: Float = 1.7000000476837158, sulphurDioxide: Float = 3.5, pm2_5: Float = 2.200000047683716, pm10: Float = 3.200000047683716, usEpaIndex: Int = 1, gbDefraIndex: Int = 1) -> (model: AirQuality, json: [String: Any]) {
        
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
