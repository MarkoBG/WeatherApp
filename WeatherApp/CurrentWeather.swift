//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

struct CurrentWeather {
    let lastUpdated: String
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
    let airQuality: AirQuality
}

struct WeatherCondition {
    let description: String
    let icon: String
    let code: Int
}

struct AirQuality {
    let carbonMonoxide: Float
    let ozon: Float
    let nitrogenDioxide: Float
    let sulphurDioxide: Float
    let pm2_5: Float
    let pm10: Float
    let usEpaIndex: Int  // 1 - Good, 2 - Moderate, 3 - Unhealthy for sensitive group,
                         // 4 - Unhealty, 5 - Very Unhealty, 6 - Hazardous

    let gbDefraIndex: Int
}
