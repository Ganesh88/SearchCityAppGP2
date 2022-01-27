//
//  SearchViewModelTests.swift
//  SearchCityAppGPTests
//
//  Created by Ganesh Pathe on 21/12/21.
//

import XCTest
import PromiseKit

class EventsSearchServiceMock: GetEventsSearchService {
    func getEventsList(searchString: String, page: Int) -> Promise<EventsResponseModel> {
        return Promise {
            seal in
            
            seal.fulfill(EventsResponseModel(events: [], meta: MetaModel()))
        }
    }
    
    /*func getEventsList(searchString: String,
                       page: Int,
                       callback: @escaping ((EventsResponseModel?, Error?) -> Void)) -> Void {
        callback(EventsResponseModel(events: [], meta: MetaModel()), nil)
    }*/
}

class SearchViewModelTests: XCTestCase {
    
    let eventsSearchServiceMock = EventsSearchServiceMock()
    var searchViewModel: SearchViewModel?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        searchViewModel = SearchViewModel(searchEventsService: eventsSearchServiceMock)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetEventsForSearchQuery() {
        searchViewModel?.getEventsForSearchQuery(searchString: "test",
                                                 pageCount: 1)
        XCTAssertTrue(true)
    }
    
    func testisValidSearchStringForSuccess() {
        let status = searchViewModel?.isValidSearchString(searchString: "test")
        if let status = status {
            XCTAssertTrue(status)
        } else {
            XCTAssertTrue(false)
        }
        
    }
    
    func testisValidSearchStringForFailure() {
        let status = searchViewModel?.isValidSearchString(searchString: "")
        if let status = status {
            XCTAssertFalse(status)
        } else {
            XCTAssertTrue(false)
        }
    }
}
