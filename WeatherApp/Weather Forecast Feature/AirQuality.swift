//
//  AirQuality.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

public struct AirQuality {
    public let carbonMonoxide: Double
    public let ozon: Double
    public let nitrogenDioxide: Double
    public let sulphurDioxide: Double
    public let pm2_5: Double
    public let pm10: Double
    public let usEpaIndex: Int  // 1 - Good, 2 - Moderate, 3 - Unhealthy for sensitive group,
                         // 4 - Unhealty, 5 - Very Unhealty, 6 - Hazardous

    public let gbDefraIndex: Int
    
    public init(carbonMonoxide: Double, ozon: Double, nitrogenDioxide: Double, sulphurDioxide: Double, pm2_5: Double, pm10: Double, usEpaIndex: Int, gbDefraIndex: Int) {
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

