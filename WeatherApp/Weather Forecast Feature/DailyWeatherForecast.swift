//
//  DailyWeatherForecast.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

public struct DailyWeatherForecast {
    public let date: String
    public let dateUnixTime: Int
    public let day: DailyWeather
    public let astrology: Astrology
    public let hours: [WeatherByHour]
    
    public init(date: String, dateUnixTime: Int, day: DailyWeather, astrology: Astrology, hours: [WeatherByHour]) {
        self.date = date
        self.dateUnixTime = dateUnixTime
        self.day = day
        self.astrology = astrology
        self.hours = hours
    }
}

public struct DailyWeather {
    public let maxTempCelsius: Float
    public let maxTempFahrenheit: Float
    public let minTempCelsius: Float
    public let minTempFahrenheit: Float
    public let avgTempCelsius: Float
    public let avgTempFahrenheit: Float
    public let maxWindMph: Float
    public let maxWingKph: Float
    public let totalprecipitationMM: Float
    public let totalprecipitationIN: Float
    public let averageVisibilityKM: Float
    public let averageVisibilityMiles: Float
    public let averageHumidity: Int
    public let dailyChanceOfRain: String
    public let dailyChanceOfSnow: String
    public let condition: WeatherCondition
    public let uvIndex: Float
    
    public init(maxTempCelsius: Float, maxTempFahrenheit: Float, minTempCelsius: Float, minTempFahrenheit: Float, avgTempCelsius: Float, avgTempFahrenheit: Float, maxWindMph: Float, maxWingKph: Float, totalprecipitationMM: Float, totalprecipitationIN: Float, averageVisibilityKM: Float, averageVisibilityMiles: Float, averageHumidity: Int, dailyChanceOfRain: String, dailyChanceOfSnow: String, condition: WeatherCondition, uvIndex: Float) {
        self.maxTempCelsius = maxTempCelsius
        self.maxTempFahrenheit = maxTempFahrenheit
        self.minTempCelsius = minTempCelsius
        self.minTempFahrenheit = minTempFahrenheit
        self.avgTempCelsius = avgTempCelsius
        self.avgTempFahrenheit = avgTempFahrenheit
        self.maxWindMph = maxWindMph
        self.maxWingKph = maxWingKph
        self.totalprecipitationMM = totalprecipitationMM
        self.totalprecipitationIN = totalprecipitationIN
        self.averageVisibilityKM = averageVisibilityKM
        self.averageVisibilityMiles = averageVisibilityMiles
        self.averageHumidity = averageHumidity
        self.dailyChanceOfRain = dailyChanceOfRain
        self.dailyChanceOfSnow = dailyChanceOfSnow
        self.condition = condition
        self.uvIndex = uvIndex
    }
}

public struct Astrology {
    public let sunrise: String
    public let sunset: String
    public let moonrise: String
    public let moonset: String
    public let moonPhase: String
    public let moonIllumination: String
    
    public init(sunrise: String, sunset: String, moonrise: String, moonset: String, moonPhase: String, moonIllumination: String) {
        self.sunrise = sunrise
        self.sunset = sunset
        self.moonrise = moonrise
        self.moonset = moonset
        self.moonPhase = moonPhase
        self.moonIllumination = moonIllumination
    }
}

public struct WeatherByHour {
    public let time: String
    public let timeUnixTime: Int
    public let tempCelsius: Float
    public let tempFahrenheit: Float
    public let isDay: Int
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
    public let feeelslikeFahrenheit: Float
    public let visibilityKM: Float
    public let visibilityMiles: Float
    public let uvIndex: Float
    public let chanceOfRain: Int
    public let chanceOfSnow: Int
    
    public init(time: String, timeUnixTime: Int, tempCelsius: Float, tempFahrenheit: Float, isDay: Int, condition: WeatherCondition, windMph: Float, windKph: Float, windDegree: Int, windDirection: String, pressureMb: Float, pressureIn: Float, precipitationMM: Float, precipitationIN: Float, humidity: Int, cloud: Int, feelslikeCelsius: Float, feeelslikeFahrenheit: Float, visibilityKM: Float, visibilityMiles: Float, uvIndex: Float, chanceOfRain: Int, chanceOfSnow: Int) {
        self.time = time
        self.timeUnixTime = timeUnixTime
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
        self.feeelslikeFahrenheit = feeelslikeFahrenheit
        self.visibilityKM = visibilityKM
        self.visibilityMiles = visibilityMiles
        self.uvIndex = uvIndex
        self.chanceOfRain = chanceOfRain
        self.chanceOfSnow = chanceOfSnow
    }
}
