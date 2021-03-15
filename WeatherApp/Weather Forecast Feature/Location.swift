//
//  Location.swift
//  WeatherApp
//
//  Created by Marko Tribl on 3/7/21.
//

import Foundation

public struct Location {
    public let name: String
    public let region: String
    public let country: String
    public let latitude: Double
    public let longitude: Double
    public let timeZoneId: String
    public let localTime: String
    
    public init(name: String, region: String, country: String, latitude: Double, longitude: Double, timeZoneId: String, localTime: String) {
        self.name = name
        self.region = region
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
        self.timeZoneId = timeZoneId
        self.localTime = localTime
    }
}

extension Location: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case region
        case country
        case latitude = "lat"
        case longitude = "lon"
        case timeZoneId = "tz_id"
        case localTime = "localtime"
    }
}
