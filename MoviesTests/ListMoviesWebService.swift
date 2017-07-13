//
//  ListMoviesWebService.swift
//  Movies
//
//  Created by Jaime Laino on 7/13/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import Movies

class ListMoviesWebServiceTest: XCTestCase {
    
    func testListMoviesWebService_Success() {
        let service : ListMovies = ListMoviesWebService()
        let waitingForService = expectation(description: "ListMoviesWebServiceExpectation")
        
        stubSuccessResponse()
        service.listMovies(listType: .inTheathersNow, page: 1) { (list, errorMessage) in
            guard let message = errorMessage else {
                waitingForService.fulfill()
                
                XCTAssertEqual(list.first?.id, "324852")
                XCTAssertEqual(list.first?.title, "Despicable Me 3")
                XCTAssertEqual(list.first?.summary, "Gru and his wife Lucy must stop former \'80s child star Balthazar Bratt from achieving world domination.")
                XCTAssertEqual(list.first?.posterImageURL.absoluteString, ListMoviesWebService.imgBaseURL + "/5qcUGqWoWhEsoQwNUrtf3y3fcWn.jpg")
                XCTAssertEqual(list.last?.id, "315635")
                return
            }
            
            XCTFail("### Fail: \(message) ###")
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testListMoviesWebService_Failure() {
        let service : ListMovies = ListMoviesWebService()
        let waitingForService = expectation(description: "ListMoviesWebServiceExpectation")
        
        stubFailureResponse()
        service.listMovies(listType: .inTheathersNow, page: 1) { (list, errorMessage) in
            guard let message = errorMessage else {
                XCTFail("### Fail ###")
                return
            }
            
            waitingForService.fulfill()
            XCTAssertEqual(message, "-1220 : Failure Test Message.")
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
 
    func testListMoviesWebService_NoInternetConnection() {
        let service : ListMovies = ListMoviesWebService()
        let waitingForService = expectation(description: "ListMoviesWebServiceExpectation")
        
        stubNoInternetConnectionResponse()
        service.listMovies(listType: .inTheathersNow, page: 1) { (list, errorMessage) in
            guard let message = errorMessage else {
                XCTFail("### Fail ###")
                return
            }
            
            waitingForService.fulfill()
            XCTAssertEqual(message, "Not Connected to Internet")
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}

fileprivate extension ListMoviesWebServiceTest {
    func stubSuccessResponse() {
        let mockPage = 1
        let mockTotalResults = 20
        let mockTotalPages = 2
        let mockResults = [
            [
                "id" : 324852,
                "title" : "Despicable Me 3",
                "overview" : "Gru and his wife Lucy must stop former \'80s child star Balthazar Bratt from achieving world domination.",
                "poster_path" : "/5qcUGqWoWhEsoQwNUrtf3y3fcWn.jpg"
            ],
            [
                "id" : 315635,
                "title" : "Spider-Man: Homecoming",
                "overview" : "Following the events of Captain America: Civil War, Peter Parker, with the help of his mentor Tony Stark, tries to balance his life as an ordinary high school student in Queens, New York City, with fighting crime as his superhero alter ego Spider-Man as a new threat, the Vulture, emerges.",
                "poster_path" : "/c24sv2weTHPsmDa7jEMN0m2P3RT.jpg"
            ]
        ]
        
        
        stub(condition: isHost("api.themoviedb.org")) { _ in
            let mockMovieResponse: [String : Any] = [
                "page" : mockPage,
                "results" : mockResults,
                "total_results" : mockTotalResults,
                "total_pages" : mockTotalPages
            ]
            return OHHTTPStubsResponse(jsonObject: mockMovieResponse,
                                       statusCode: 200,
                                       headers: nil)
        }
    }
    
    func stubFailureResponse() {
        stub(condition: isHost("api.themoviedb.org")) { _ in
            return OHHTTPStubsResponse(jsonObject: ["status_message": "Failure Test Message.",
                                                    "status_code": -1220],
                                       statusCode: 401,
                                       headers: nil)
        }
    }
    
    func stubNoInternetConnectionResponse() {
        stub(condition: isHost("api.themoviedb.org")) { _ in
            return OHHTTPStubsResponse(error: NSError(domain: NSURLErrorDomain,
                                                      code: NSURLErrorNotConnectedToInternet,
                                                      userInfo: nil))
        }
    }
    
}
