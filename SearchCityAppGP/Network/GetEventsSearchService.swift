//
//  GetEventsSearchService.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 15/12/21.
//

import Foundation

protocol GetEventsSearchService {
    func getEventsList(searchString: String,
                       page: Int,
                       callback: @escaping ((EventsResponseModel?, Error?) -> Void)) -> Void
}
