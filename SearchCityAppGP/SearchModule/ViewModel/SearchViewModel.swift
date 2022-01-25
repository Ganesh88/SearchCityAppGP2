//
//  SearchViewModel.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 15/12/21.
//

import Foundation
import RxSwift
import RxRelay
import PromiseKit

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
    
    // One without promise kit
    
    /*func getEventsForSearchQuery(searchString: String,
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
    }*/
    
    // One with promise kit

    func getEventsForSearchQuery(searchString: String,
                                 pageCount: Int) {
        if !(isValidSearchString(searchString: searchString)) { self.eventsListArray.accept( [] )
            return
        }
        firstly {
            Utilities.instance.checkConnectivity()
        }.then {
            isConnected -> Promise <EventsResponseModel> in
            if !isConnected {
                throw AppError.networkError
            } else {
                let eventsResponseModel = self.searchEventsService?.getEventsList(searchString: searchString, page: pageCount)
                if let eventsResponseModel = eventsResponseModel {
                    return eventsResponseModel
                } else {
                    throw AppError.defaultError
                }
            }
        }.done {
            eventsResponseModel -> Void in
            kTotalEventsPageCount = eventsResponseModel.meta.totalPages
            self.eventsListArray.accept(eventsResponseModel.events)
        }.catch {
            error in
            print( error.localizedDescription)
            Utilities.instance.showAlert(title:"", message: error.localizedDescription)
        }.finally {}
    }
}
