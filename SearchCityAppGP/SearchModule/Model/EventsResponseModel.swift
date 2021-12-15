//
//  EventsResponseModel.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 15/12/21.
//

import Foundation

struct EventsResponseModel: Codable {
    let events: [CityModel]
    let meta: MetaModel
}

struct MetaModel: Codable {
    let total: Int
    let page: Int
    let per_page: Int
    
    private enum CodingKeys: String, CodingKey {
        case total
        case page
        case per_page = "per_page"
    }
}