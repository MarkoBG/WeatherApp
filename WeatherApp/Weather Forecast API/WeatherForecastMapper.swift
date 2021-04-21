//
//  WeatherForecastMapper.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/25/21.
//

import Foundation

internal final class WeatherForecastMapper {
    
    private struct AirQualityAPI: Decodable {
        let co: Double
        let o3: Double
        let no2: Double
        let so2: Double
        let pm2_5: Double
        let pm10: Double
        let us_epa_index: Int
        let gb_defra_index: Int
        
        private enum CodingKeys: String, CodingKey {
            case co
            case o3
            case no2
            case so2
            case pm2_5
            case pm10
            case us_epa_index = "us-epa-index"
            case gb_defra_index = "gb-defra-index"
        }
        
        var airQuality: AirQuality {
            return AirQuality(carbonMonoxide: co, ozon: o3, nitrogenDioxide: no2, sulphurDioxide: so2, pm2_5: pm2_5, pm10: pm10, usEpaIndex: us_epa_index, gbDefraIndex: gb_defra_index)
        }
    }
    
     private struct CurrentWeatherAPI: Decodable {
        let last_updated: String
        let temp_c: Double
        let temp_f: Double
        let is_day: Int
        let condition: WeatherConditionAPI
        let wind_mph: Double
        let wind_kph: Double
        let wind_degree: Int
        let wind_dir: String
        let pressure_mb: Double
        let pressure_in: Double
        let precip_mm: Double
        let precip_in: Double
        let humidity: Int
        let cloud: Int
        let feelslike_c: Double
        let feelslike_f: Double
        let vis_km: Double
        let vis_miles: Double
        let uv: Double
        let air_quality: AirQualityAPI
        
        var current: CurrentWeather {
            return CurrentWeather(lastUpdated: last_updated, tempCelsius: temp_c, tempFahrenheit: temp_f, isDay: is_day, condition: condition.weatherCondition, windMph: wind_mph, windKph: wind_kph, windDegree: wind_degree, windDirection: wind_dir, pressureMb: pressure_mb, pressureIn: pressure_in, precipitationMM: precip_mm, precipitationIN: precip_in, humidity: humidity, cloud: cloud, feelslikeCelsius: feelslike_c, feelslikeFahrenheit: feelslike_f, visibilityKM: vis_km, visibilityMiles: vis_miles, uvIndex: uv, airQuality: air_quality.airQuality)
        }
    }
    
    private struct LocationAPI: Decodable {
        let name: String
        let region: String
        let country: String
        let lat: Double
        let lon: Double
        let tz_id: String
        let localtime: String
        
        var location: Location {
            return Location(name: name, region: region, country: country, latitude: lat, longitude: lon, timeZoneId: tz_id, localTime: localtime)
        }
    }
    
    private struct WeatherConditionAPI: Decodable {
        let text: String
        let icon: String
        let code: Int
        
        var weatherCondition: WeatherCondition {
            return WeatherCondition(description: text, iconURL: icon, code: code)
        }
    }
    
    private struct DailyWeatherAPI: Decodable {
        let maxtemp_c: Double
        let maxtemp_f: Double
        let mintemp_c: Double
        let mintemp_f: Double
        let avgtemp_c: Double
        let avgtemp_f: Double
        let maxwind_mph: Double
        let maxwind_kph: Double
        let totalprecip_mm: Double
        let totalprecip_in: Double
        let avgvis_km: Double
        let avgvis_miles: Double
        let avghumidity: Double
        let daily_chance_of_rain: String
        let daily_chance_of_snow: String
        let condition: WeatherConditionAPI
        let uv: Double
        
        var dailyWeather: DailyWeather {
            return DailyWeather(maxTempCelsius: maxtemp_c, maxTempFahrenheit: maxtemp_f, minTempCelsius: mintemp_c, minTempFahrenheit: mintemp_f, avgTempCelsius: avgtemp_c, avgTempFahrenheit: avgtemp_f, maxWindMph: maxwind_mph, maxWingKph: maxwind_mph, totalprecipitationMM: totalprecip_mm, totalprecipitationIN: totalprecip_in, averageVisibilityKM: avgvis_km, averageVisibilityMiles: avgvis_miles, averageHumidity: avghumidity, dailyChanceOfRain: daily_chance_of_rain, dailyChanceOfSnow: daily_chance_of_snow, condition: condition.weatherCondition, uvIndex: uv)
        }
    }
    
    private struct AstroAPI: Decodable {
        let sunrise: String
        let sunset: String
        let moonrise: String
        let moonset: String
        let moon_phase: String
        let moon_illumination: String
        
        var astrology: Astrology {
            return Astrology(sunrise: sunrise, sunset: sunset, moonrise: moonrise, moonset: moonset, moonPhase: moon_phase, moonIllumination: moon_illumination)
        }
    }
    
    private struct WeatherByHourAPI: Decodable {
        let time: String
        let time_epoch: Int
        let temp_c: Double
        let temp_f: Double
        let is_day: Int
        let condition: WeatherConditionAPI
        let wind_mph: Double
        let wind_kph: Double
        let wind_degree: Int
        let wind_dir: String
        let pressure_mb: Double
        let pressure_in: Double
        let precip_mm: Double
        let precip_in: Double
        let humidity: Int
        let cloud: Int
        let feelslike_c: Double
        let feelslike_f: Double
        let vis_km: Double
        let vis_miles: Double
        let uv: Double
        let chance_of_rain: String
        let chance_of_snow: String
        
        var weatherByHour: WeatherByHour {
            return WeatherByHour(time: time, timeUnixTime: time_epoch, tempCelsius: temp_c, tempFahrenheit: temp_f, isDay: is_day, condition: condition.weatherCondition, windMph: wind_mph, windKph: wind_kph, windDegree: wind_degree, windDirection: wind_dir, pressureMb: pressure_mb, pressureIn: pressure_in, precipitationMM: precip_mm, precipitationIN: precip_in, humidity: humidity, cloud: cloud, feelslikeCelsius: feelslike_c, feeelslikeFahrenheit: feelslike_f, visibilityKM: vis_km, visibilityMiles: vis_miles, uvIndex: uv, chanceOfRain: chance_of_rain, chanceOfSnow: chance_of_snow)
        }
    }
    
    private struct DailyForecastAPI: Decodable {
        let date: String
        let date_epoch: Int
        let day: DailyWeatherAPI
        let astro: AstroAPI
        let hour: [WeatherByHourAPI]
        
        private var hours: [WeatherByHour] {
            return hour.map{$0.weatherByHour}
        }
        
        var dailyWeatherForecast: DailyWeatherForecast {
            return DailyWeatherForecast(date: date, dateUnixTime: date_epoch, day: day.dailyWeather, astrology: astro.astrology, hours: hours)
        }
    }
    
    private struct ForecastDaysAPI: Decodable {
        let forecastday: [DailyForecastAPI]
        
        private var dailyWeatherForecast: [DailyWeatherForecast] {
            return forecastday.map {$0.dailyWeatherForecast}
        }
        
        var forecast: Forecast {
            return Forecast(days: dailyWeatherForecast)
        }
    }
    
    private struct WeatherAPI: Decodable {
        let location: LocationAPI
        let current: CurrentWeatherAPI
        let forecast: ForecastDaysAPI
        
        var weatherForecast: WeatherForecast {
            return WeatherForecast(location: location.location, currentWeather: current.current, forecast: forecast.forecast)
        }
    }
    
    private static var OK_200: Int {
        return 200
    }
    
    internal static func map(_ data: Data, response: HTTPURLResponse) -> RemoteWeatherLoader.Result {
        
        guard response.statusCode == OK_200, let weatherForecast = try? JSONDecoder().decode(WeatherAPI.self, from: data) else {
            return .failure(RemoteWeatherLoader.Error.invalidData)
        }
        
        return .success(weatherForecast.weatherForecast)
    }
}
