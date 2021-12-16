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
    let imageUrl: String
    let venue: VenueModel
    let performers: [PerformersModel]
    
    private enum CodingKeys: String, CodingKey {
        case type
        case id
        case datetimeUtc = "datetime_utc"
        case shortTitle = "short_title"
        case title
        case imageUrl = "url"
        case venue
        case performers
    }
}

struct VenueModel: Codable {
    let displayLocation: String
    
    private enum CodingKeys: String, CodingKey {
        case displayLocation = "display_location"
    }
}

struct PerformersModel: Codable {
    let imageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case imageUrl = "image"
    }
}
