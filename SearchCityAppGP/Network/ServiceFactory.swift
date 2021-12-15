//
//  ServiceFactory.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 15/12/21.
//

import Foundation

class ServiceFactory: IServiceFactory {
    func getEventsSearchService() -> GetEventsSearchService {
       return GetEventsSearchServiceCalls()
   }
}
