//
//  IServiceFactory.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 15/12/21.
//

import Foundation

protocol IServiceFactory {
    func getEventsSearchService() -> GetEventsSearchService 
}
