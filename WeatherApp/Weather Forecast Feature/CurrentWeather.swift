//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

public struct CurrentWeather {
    public let lastUpdated: String
    public let tempCelsius: Double
    public let tempFahrenheit: Double
    public let isDay: Int  // 1 - yes, 0 - no
    public let condition: WeatherCondition
    public let windMph: Double
    public let windKph: Double
    public let windDegree: Int
    public let windDirection: String
    public let pressureMb: Double
    public let pressureIn: Double
    public let precipitationMM: Double
    public let precipitationIN: Double
    public let humidity: Int
    public let cloud: Int
    public let feelslikeCelsius: Double
    public let feelslikeFahrenheit: Double
    public let visibilityKM: Double
    public let visibilityMiles: Double
    public let uvIndex: Double
    public let airQuality: AirQuality
    
    public init(lastUpdated: String, tempCelsius: Double, tempFahrenheit: Double, isDay: Int, condition: WeatherCondition, windMph: Double, windKph: Double, windDegree: Int, windDirection: String, pressureMb: Double, pressureIn: Double, precipitationMM: Double, precipitationIN: Double, humidity: Int, cloud: Int, feelslikeCelsius: Double, feelslikeFahrenheit: Double, visibilityKM: Double, visibilityMiles: Double, uvIndex: Double, airQuality: AirQuality) {
        self.lastUpdated = lastUpdated
        self.tempCelsius = tempCelsius
        self.tempFahrenheit = tempFahrenheit
        self.isDay = isDay
        self.condition = condition
        self.windMph = windMph
        self.windKph = windKph
        self.windDegree = windDegree
        self.windDirection = windDirection
        self.pressureMb = pressureMb
        self.pressureIn = pressureIn
        self.precipitationMM = precipitationMM
        self.precipitationIN = precipitationIN
        self.humidity = humidity
        self.cloud = cloud
        self.feelslikeCelsius = feelslikeCelsius
        self.feelslikeFahrenheit = feelslikeFahrenheit
        self.visibilityKM = visibilityKM
        self.visibilityMiles = visibilityMiles
        self.uvIndex = uvIndex
        self.airQuality = airQuality
    }
}
