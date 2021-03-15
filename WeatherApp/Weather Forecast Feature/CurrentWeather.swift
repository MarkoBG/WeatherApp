//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

public struct CurrentWeather {
    public let lastUpdated: String
    public let tempCelsius: Float
    public let tempFahrenheit: Float
    public let isDay: Int  // 1 - yes, 0 - no
    public let condition: WeatherCondition
    public let windMph: Float
    public let windKph: Float
    public let windDegree: Int
    public let windDirection: String
    public let pressureMb: Float
    public let pressureIn: Float
    public let precipitationMM: Float
    public let precipitationIN: Float
    public let humidity: Int
    public let cloud: Int
    public let feelslikeCelsius: Float
    public let feelslikeFahrenheit: Float
    public let visibilityKM: Float
    public let visibilityMiles: Float
    public let uvIndex: Float
    public let airQuality: AirQuality
    
    public init(lastUpdated: String, tempCelsius: Float, tempFahrenheit: Float, isDay: Int, condition: WeatherCondition, windMph: Float, windKph: Float, windDegree: Int, windDirection: String, pressureMb: Float, pressureIn: Float, precipitationMM: Float, precipitationIN: Float, humidity: Int, cloud: Int, feelslikeCelsius: Float, feelslikeFahrenheit: Float, visibilityKM: Float, visibilityMiles: Float, uvIndex: Float, airQuality: AirQuality) {
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

extension CurrentWeather: Decodable {
    private enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempCelsius = "temp_c"
        case tempFahrenheit = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDirection = "wind_dir"
        case pressureMb = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipitationMM = "precip_mm"
        case precipitationIN = "precip_in"
        case humidity
        case cloud
        case feelslikeCelsius = "feelslike_c"
        case feelslikeFahrenheit = "feelslike_f"
        case visibilityKM = "vis_km"
        case visibilityMiles = "vis_miles"
        case uvIndex = "uv"
        case airQuality = "air_quality"
    }
}
