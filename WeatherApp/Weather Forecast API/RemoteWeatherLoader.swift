//
//  File.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

public final class RemoteWeatherLoader: WeatherLoader {
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = WeatherLoaderResult
        
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success(data, response):
                completion(RemoteWeatherLoader.map(data, from: response))
                
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let weatherForecastAPI = try WeatherForecastMapper.map(data, response: response)
            return .success(weatherForecastAPI.toModel())
        } catch {
            return .failure(error)
        }
    }
}

private extension WeatherAPI {
    func toModel() -> WeatherForecast {
        let locationModel = Location(name: location.name, region: location.region, country: location.country, latitude: location.lat, longitude: location.lon, timeZoneId: location.tz_id, localTime: location.localtime)
        
        let weatherConditionModel = WeatherCondition(description: current.condition.text, iconURL: current.condition.icon, code: current.condition.code)
        
        let airQualityModel = AirQuality(carbonMonoxide: current.air_quality.co, ozon: current.air_quality.o3, nitrogenDioxide: current.air_quality.no2, sulphurDioxide: current.air_quality.so2, pm2_5: current.air_quality.pm2_5, pm10: current.air_quality.pm10, usEpaIndex: current.air_quality.us_epa_index, gbDefraIndex: current.air_quality.gb_defra_index)
        
        let currentWeatherModel = CurrentWeather(lastUpdated: current.last_updated, tempCelsius: current.temp_c, tempFahrenheit: current.temp_f, isDay: current.is_day, condition: weatherConditionModel, windMph: current.wind_mph, windKph: current.wind_kph, windDegree: current.wind_degree, windDirection: current.wind_dir, pressureMb: current.pressure_mb, pressureIn: current.pressure_in, precipitationMM: current.precip_mm, precipitationIN: current.precip_in, humidity: current.humidity, cloud: current.cloud, feelslikeCelsius: current.feelslike_c, feelslikeFahrenheit: current.feelslike_f, visibilityKM: current.vis_km, visibilityMiles: current.vis_miles, uvIndex: current.uv, airQuality: airQualityModel)
        
        let dalyWeatherForecastModel: [DailyWeatherForecast] = forecast.forecastday.map { forecastAPI in
            let dailyWeather = DailyWeather(maxTempCelsius: forecastAPI.day.maxtemp_c, maxTempFahrenheit: forecastAPI.day.maxtemp_f, minTempCelsius: forecastAPI.day.mintemp_c, minTempFahrenheit: forecastAPI.day.mintemp_f, avgTempCelsius: forecastAPI.day.avgtemp_c, avgTempFahrenheit: forecastAPI.day.avgtemp_f, maxWindMph: forecastAPI.day.maxwind_mph, maxWingKph: forecastAPI.day.maxwind_kph, totalprecipitationMM: forecastAPI.day.totalprecip_mm, totalprecipitationIN: forecastAPI.day.totalprecip_in, averageVisibilityKM: forecastAPI.day.avgvis_km, averageVisibilityMiles: forecastAPI.day.avgvis_miles, averageHumidity: forecastAPI.day.avghumidity, dailyChanceOfRain: forecastAPI.day.daily_chance_of_rain, dailyChanceOfSnow: forecastAPI.day.daily_chance_of_snow, condition: weatherConditionModel, uvIndex: forecastAPI.day.uv)
            let dailyWeatherForecast = DailyWeatherForecast(date: forecastAPI.date, dateUnixTime: forecastAPI.date_epoch, day: dailyWeather, astrology: Astrology(sunrise: forecastAPI.astro.sunset, sunset: forecastAPI.astro.sunset, moonrise: forecastAPI.astro.moonrise, moonset: forecastAPI.astro.moonset, moonPhase: forecastAPI.astro.moon_phase, moonIllumination: forecastAPI.astro.moon_illumination), hours: forecastAPI.hour.map { WeatherByHour(time: $0.time, timeUnixTime: $0.time_epoch, tempCelsius: $0.temp_c, tempFahrenheit: $0.temp_f, isDay: $0.is_day, condition: WeatherCondition(description: $0.condition.text, iconURL: $0.condition.icon, code: $0.condition.code), windMph: $0.wind_mph, windKph: $0.wind_kph, windDegree: $0.wind_degree, windDirection: $0.wind_dir, pressureMb: $0.pressure_mb, pressureIn: $0.pressure_in, precipitationMM: $0.precip_mm, precipitationIN: $0.precip_in, humidity: $0.humidity, cloud: $0.cloud, feelslikeCelsius: $0.feelslike_c, feeelslikeFahrenheit: $0.feelslike_f, visibilityKM: $0.vis_km, visibilityMiles: $0.vis_miles, uvIndex: $0.uv, chanceOfRain: $0.chance_of_rain, chanceOfSnow: $0.chance_of_snow)})
            return dailyWeatherForecast
        }
        
        let forecastModel = Forecast(days: dalyWeatherForecastModel)
        
        return WeatherForecast(location: locationModel, currentWeather: currentWeatherModel, forecast: forecastModel)
    }
}
