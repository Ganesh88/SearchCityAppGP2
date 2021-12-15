//
//  CityModel.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 15/12/21.
//

import Foundation

struct CityModel: Codable {
    let type: String
    let id: Int
    let datetimeUtc: String
    let shortTitle: String
    let title: String
    let location: [String: String]
    let url: String
    let venue: VenueModel
    
    private enum CodingKeys: String, CodingKey {
        case type
        case id
        case datetimeUtc = "datetime_utc"
        case shortTitle = "short_title"
        case title
        case location
        case url
        case venue
    }
}

struct VenueModel: Codable {
    let displayLocation: String
    
    private enum CodingKeys: String, CodingKey {
        case displayLocation = "display_location"
    }
}
