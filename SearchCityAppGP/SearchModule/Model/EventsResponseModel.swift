//
//  EventsResponseModel.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 15/12/21.
//

import Foundation

struct EventsResponseModel: Codable {
    let events: [EventsModel]
    let meta: MetaModel
}

struct MetaModel: Codable {
    let total: Int
    let page: Int
    let perPage: Int
    
    private enum CodingKeys: String, CodingKey {
        case total
        case page
        case perPage = "per_page"
    }
    
    init() {
        total = 100
        page = 1
        perPage = 25
    }
    
    var totalPages : Int {
        get {
            return (total + perPage - 1) / perPage
        }
    }
}
