//
//  SearchViewModel.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 15/12/21.
//

import Foundation
import RxSwift
import RxRelay

class SearchViewModel {
    var searchEventsService: GetEventsSearchService?
    var eventsListArray = BehaviorRelay<[CityModel]>(value: [])
    
    init(searchEventsService: GetEventsSearchService) {
        self.searchEventsService = searchEventsService
    }
    
    func getEventsForSearchQuery() {
        searchEventsService?.getEventsList(page: 1, callback: { (eventsResponseModel, error) in
            self.eventsListArray.accept(eventsResponseModel?.events ?? [])
        })
    }
}
