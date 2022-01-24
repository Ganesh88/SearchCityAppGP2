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
    var eventsListArray = BehaviorRelay<[EventsModel]>(value: [])
    var searchText = BehaviorRelay(value: "")
    
    init(searchEventsService: GetEventsSearchService) {
        self.searchEventsService = searchEventsService
    }
    
    func isValidSearchString(searchString: String) -> Bool {
        if !searchString.isEmpty && searchString.count > 2 {
            return true
        }
        return false
    }
    
    func getEventsForSearchQuery(searchString: String,
                                 pageCount: Int) {
        if !(isValidSearchString(searchString: searchString)) { self.eventsListArray.accept( [] )
            return
        }
        searchEventsService?.getEventsList(searchString: searchString,
                                           page: pageCount,
                                           callback: { (eventsResponseModel, error) in
                                            kTotalEventsPageCount = eventsResponseModel?.meta.totalPages ?? 0
                                            self.eventsListArray.accept(eventsResponseModel?.events ?? [])
                                           })
    }
}
