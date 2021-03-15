//
//  AirQuality.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

public struct AirQuality {
    public let carbonMonoxide: Float
    public let ozon: Float
    public let nitrogenDioxide: Float
    public let sulphurDioxide: Float
    public let pm2_5: Float
    public let pm10: Float
    public let usEpaIndex: Int  // 1 - Good, 2 - Moderate, 3 - Unhealthy for sensitive group,
                         // 4 - Unhealty, 5 - Very Unhealty, 6 - Hazardous

    public let gbDefraIndex: Int
    
    public init(carbonMonoxide: Float, ozon: Float, nitrogenDioxide: Float, sulphurDioxide: Float, pm2_5: Float, pm10: Float, usEpaIndex: Int, gbDefraIndex: Int) {
        self.carbonMonoxide = carbonMonoxide
        self.ozon = ozon
        self.nitrogenDioxide = nitrogenDioxide
        self.sulphurDioxide = sulphurDioxide
        self.pm2_5 = pm2_5
        self.pm10 = pm10
        self.usEpaIndex = usEpaIndex
        self.gbDefraIndex = gbDefraIndex
    }
}

extension AirQuality: Decodable {
    private enum CodingKeys: String, CodingKey {
        case carbonMonoxide = "co"
        case ozon = "o3"
        case nitrogenDioxide = "no2"
        case sulphurDioxide = "so2"
        case pm2_5
        case pm10
        case usEpaIndex = "us-epa-index"
        case gbDefraIndex = "gb-defra-index"
    }
}
