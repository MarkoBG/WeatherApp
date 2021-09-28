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
    public let maxTempCelsius: Double
    public let maxTempFahrenheit: Double
    public let minTempCelsius: Double
    public let minTempFahrenheit: Double
    public let avgTempCelsius: Double
    public let avgTempFahrenheit: Double
    public let maxWindMph: Double
    public let maxWingKph: Double
    public let totalprecipitationMM: Double
    public let totalprecipitationIN: Double
    public let averageVisibilityKM: Double
    public let averageVisibilityMiles: Double
    public let averageHumidity: Double
    public let dailyChanceOfRain: Int
    public let dailyChanceOfSnow: Int
    public let condition: WeatherCondition
    public let uvIndex: Double
    
    public init(maxTempCelsius: Double, maxTempFahrenheit: Double, minTempCelsius: Double, minTempFahrenheit: Double, avgTempCelsius: Double, avgTempFahrenheit: Double, maxWindMph: Double, maxWingKph: Double, totalprecipitationMM: Double, totalprecipitationIN: Double, averageVisibilityKM: Double, averageVisibilityMiles: Double, averageHumidity: Double, dailyChanceOfRain: Int, dailyChanceOfSnow: Int, condition: WeatherCondition, uvIndex: Double) {
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
    public let tempCelsius: Double
    public let tempFahrenheit: Double
    public let isDay: Int
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
    public let feeelslikeFahrenheit: Double
    public let visibilityKM: Double
    public let visibilityMiles: Double
    public let uvIndex: Double
    public let chanceOfRain: Int
    public let chanceOfSnow: Int
    
    public init(time: String, timeUnixTime: Int, tempCelsius: Double, tempFahrenheit: Double, isDay: Int, condition: WeatherCondition, windMph: Double, windKph: Double, windDegree: Int, windDirection: String, pressureMb: Double, pressureIn: Double, precipitationMM: Double, precipitationIN: Double, humidity: Int, cloud: Int, feelslikeCelsius: Double, feeelslikeFahrenheit: Double, visibilityKM: Double, visibilityMiles: Double, uvIndex: Double, chanceOfRain: Int, chanceOfSnow: Int) {
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
