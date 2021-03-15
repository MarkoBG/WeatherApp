//
//  WeatherCondition.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

public struct WeatherCondition {
    public let description: String
    public let iconURL: String
    public let code: Int
    
    public init(description: String, iconURL: String, code: Int) {
        self.description = description
        self.iconURL = iconURL
        self.code = code
    }
}

extension WeatherCondition: Decodable {
    private enum CodingKeys: String, CodingKey {
        case description = "text"
        case iconURL = "icon"
        case code
    }
}
