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
    var searchText = BehaviorRelay(value: "")
    
    init(searchEventsService: GetEventsSearchService) {
        self.searchEventsService = searchEventsService
    }
    
    func getEventsForSearchQuery(searchString: String) {
        searchEventsService?.getEventsList(searchString: searchString,
                                           page: 1,
                                           callback: { (eventsResponseModel, error) in
                                            self.eventsListArray.accept(eventsResponseModel?.events ?? [])
                                           })
    }
}
