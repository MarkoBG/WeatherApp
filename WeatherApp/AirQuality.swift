//
//  AirQuality.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

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
