//
//  GetEventsSearchServiceCalls.swift
//  SearchCityAppGP
//
//  Created by Ganesh Pathe on 15/12/21.
//

import Foundation
import AFNetworking

class GetEventsSearchServiceCalls: GetEventsSearchService {
     
    func getEventsList(page: Int, callback: @escaping ((EventsResponseModel?, Error?) -> Void)) -> Void {
        let manager = AFHTTPSessionManager()
        let url = (String(format:kSearchURL,page))

        manager.get(url,
                    parameters: nil,
                    headers: nil,
                    progress: { (p) in },
                    success: { (operation, responseObject) in
                        let decoder = JSONDecoder()
                        
                        let jsonData = try? JSONSerialization.data(withJSONObject: responseObject)
                        let eventResponseModel = try? decoder.decode(EventsResponseModel.self, from: jsonData!)
                        if let eventResponseModel = eventResponseModel {
                            callback(eventResponseModel, nil)
                        }
                        callback(nil, nil)
                        
                    },
                    failure: { (operation, error) in
                        callback(nil, nil)
                    })
    }
}
