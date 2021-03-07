//
//  DailyWeatherForecast.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

struct DailyWeatherForecast {
    let date: String
    let dateUnixTime: Int
    let day: DailyWeather
    let astrology: Astrology
    let hours: [WeatherByHour]
}

struct DailyWeather {
    let maxTempCelsius: Float
    let maxTempFahrenheit: Float
    let minTempCelsius: Float
    let minTempFahrenheit: Float
    let avgTempCelsius: Float
    let avgTempFahrenheit: Float
    let maxWindMph: Float
    let maxWingKph: Float
    let totalprecipitationMM: Float
    let totalprecipitationIN: Float
    let averageVisibilityKM: Float
    let averageVisibilityMiles: Float
    let averageHumidity: Int
    let dailyChanceOfRain: String
    let dailyChanceOfSnow: String
    let condition: WeatherCondition
    let uvIndex: Float
}

struct Astrology {
    let sunrise: String
    let sunset: String
    let moonrise: String
    let moonset: String
    let moonPhase: String
    let moonIllumination: String
}

struct WeatherByHour {
    let time: String
    let timeUnixTime: Int
    let tempCelsius: Float
    let tempFahrenheit: Float
    let isDay: Bool
    let condition: WeatherCondition
    let windMph: Float
    let windKph: Float
    let windDegree: Int
    let windDirection: String
    let pressureMb: Float
    let pressureIn: Float
    let precipitationMM: Float
    let precipitationIN: Float
    let humidity: Int
    let cloud: Int
    let feelslikeCelsius: Float
    let feeelslikeFahrenheit: Float
    let visibilityKM: Float
    let visibilityMiles: Float
    let uvIndex: Float
    let chanceOfRain: Int
    let chanceOfSnow: Int
}
