//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Marko Tribl on 6/19/21.
//

import Foundation

internal struct AirQualityAPI: Decodable {
    internal let co: Double
    internal let o3: Double
    internal let no2: Double
    internal let so2: Double
    internal let pm2_5: Double
    internal let pm10: Double
    internal let us_epa_index: Int
    internal let gb_defra_index: Int
    
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
}

internal struct CurrentWeatherAPI: Decodable {
    internal let last_updated: String
    internal let temp_c: Double
    internal let temp_f: Double
    internal let is_day: Int
    internal let condition: WeatherConditionAPI
    internal let wind_mph: Double
    internal let wind_kph: Double
    internal let wind_degree: Int
    internal let wind_dir: String
    internal let pressure_mb: Double
    internal let pressure_in: Double
    internal let precip_mm: Double
    internal let precip_in: Double
    internal let humidity: Int
    internal let cloud: Int
    internal let feelslike_c: Double
    internal let feelslike_f: Double
    internal let vis_km: Double
    internal let vis_miles: Double
    internal let uv: Double
    internal let air_quality: AirQualityAPI
}

internal struct LocationAPI: Decodable {
    internal let name: String
    internal let region: String
    internal let country: String
    internal let lat: Double
    internal let lon: Double
    internal let tz_id: String
    internal let localtime: String
}

internal struct WeatherConditionAPI: Decodable {
    internal let text: String
    internal let icon: String
    internal let code: Int
}

internal struct DailyWeatherAPI: Decodable {
    internal let maxtemp_c: Double
    internal let maxtemp_f: Double
    internal let mintemp_c: Double
    internal let mintemp_f: Double
    internal let avgtemp_c: Double
    internal let avgtemp_f: Double
    internal let maxwind_mph: Double
    internal let maxwind_kph: Double
    internal let totalprecip_mm: Double
    internal let totalprecip_in: Double
    internal let avgvis_km: Double
    internal let avgvis_miles: Double
    internal let avghumidity: Double
    internal let daily_chance_of_rain: String
    internal let daily_chance_of_snow: String
    internal let condition: WeatherConditionAPI
    internal let uv: Double
}

internal struct AstroAPI: Decodable {
    internal let sunrise: String
    internal let sunset: String
    internal let moonrise: String
    internal let moonset: String
    internal let moon_phase: String
    internal let moon_illumination: String
}

internal struct WeatherByHourAPI: Decodable {
    internal let time: String
    internal let time_epoch: Int
    internal let temp_c: Double
    internal let temp_f: Double
    internal let is_day: Int
    internal let condition: WeatherConditionAPI
    internal let wind_mph: Double
    internal let wind_kph: Double
    internal let wind_degree: Int
    internal let wind_dir: String
    internal let pressure_mb: Double
    internal let pressure_in: Double
    internal let precip_mm: Double
    internal let precip_in: Double
    internal let humidity: Int
    internal let cloud: Int
    internal let feelslike_c: Double
    internal let feelslike_f: Double
    internal let vis_km: Double
    internal let vis_miles: Double
    internal let uv: Double
    internal let chance_of_rain: String
    internal let chance_of_snow: String
}

internal struct DailyForecastAPI: Decodable {
    internal let date: String
    internal let date_epoch: Int
    internal let day: DailyWeatherAPI
    internal let astro: AstroAPI
    internal let hour: [WeatherByHourAPI]
}

internal struct ForecastDaysAPI: Decodable {
    internal let forecastday: [DailyForecastAPI]
}

internal struct WeatherAPI: Decodable {
    internal let location: LocationAPI
    internal let current: CurrentWeatherAPI
    internal let forecast: ForecastDaysAPI
}
