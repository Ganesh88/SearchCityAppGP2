//
//  GetEventsSearchServiceCalls.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 15/12/21.
//

import Foundation
import AFNetworking
import PromiseKit

class GetEventsSearchServiceCalls: GetEventsSearchService {
    // One without Promise Kit
    // with AF networking
    // with decoder
    /*func getEventsList(searchString: String,
     page: Int,
     callback: @escaping ((EventsResponseModel?, Error?) -> Void)) -> Void {
     let manager = AFHTTPSessionManager()
     let url = (String(format:kSearchURL,
     kSeatGeekAPIClientID,
     searchString,
     page))
     let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
     
     
     manager.get(urlString,
     parameters: nil,
     headers: nil,
     progress: { (p) in },
     success: { (operation, responseObject) in
     let decoder = JSONDecoder()
     let jsonData = try? JSONSerialization.data(withJSONObject: responseObject!, options: JSONSerialization.WritingOptions.prettyPrinted)
     let eventResponseModel = try? decoder.decode(EventsResponseModel.self, from: jsonData!)
     print("eventResponseModel",eventResponseModel ?? "")
     if let eventResponseModel = eventResponseModel {
     callback(eventResponseModel, nil)
     }
     },
     failure: { (operation, error) in
     callback(nil, nil)
     })
     }*/
    
    
    
    // One wit Promise Kit
    func getEventsList(searchString: String,
                       page: Int) -> Promise <EventsResponseModel> {
        return Promise {
            seal in
            
        let manager = AFHTTPSessionManager()
        let url = (String(format:kSearchURL,
                          kSeatGeekAPIClientID,
                          searchString,
                          page))
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
        
        
        manager.get(urlString,
                    parameters: nil,
                    headers: nil,
                    progress: { (p) in },
                    success: { (operation, responseObject) in
                        let decoder = JSONDecoder()
                        let jsonData = try? JSONSerialization.data(withJSONObject: responseObject!, options: JSONSerialization.WritingOptions.prettyPrinted)
                        let eventResponseModel = try? decoder.decode(EventsResponseModel.self, from: jsonData!)
                        print("eventResponseModel",eventResponseModel ?? "")
                        if let eventResponseModel = eventResponseModel {
                            seal.fulfill(eventResponseModel)
                        }
                    },
                    failure: { (operation, error) in
                        seal.reject(error)
                    })
    }
    }
}
