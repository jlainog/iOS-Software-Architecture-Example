//
//  ListMoviesWebService.swift
//  Movies
//
//  Created by Jaime Laino on 7/13/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import Foundation

struct ListMoviesWebService : ListMovies {
    private static let host = "https://api.themoviedb.org/3"
    private static let apiKey = "1f4d7de5836b788bdfd897c3e0d0a24b"
    static let imgBaseURL =  "https://image.tmdb.org/t/p/w500"
    
    
    func listMovies(listType: MovieListType,
                    page: Int,
                    completionHandler: ([Movie], String?) -> Void) {
//        let urlRequest = "https://api.themoviedb.org/3" + path(forType: listType)
//        
//        Alamofire.request(urlRequest,
//                          method: .get,
//                          parameters: ["api_key": apiKey],
//                          encoding: URLEncoding.default,
//                          headers: nil)
//            .responseJSON {
//                response in
//                let moviesResponse = handleResponse(response: response)
//                
//                switch moviesResponse {
//                case .success(let movies):
//                    completionHandler(movies, nil)
//                case .failure(let error):
//                    completionHandler([], error.statusCode + "" + error.message)
//                }
//        }
    }

}

private extension ListMoviesWebService {
    func path(forType type: MovieListType) -> String {
        switch type {
        case .inTheathersNow: return "/movie/now_playing"
        case .upcoming: return "/movie/upcoming"
        }
        
    }
    
    //    func handleResponse<T:Parseable>(response: Alamofire.DataResponse<Any>) -> MovieWebServiceResponse<T> {
    //        guard let statusCode = response.response?.statusCode,
    //            let value = response.result.value as? NSDictionary,
    //            response.result.isSuccess == true else {
    //                if let error = response.result.error as? NSError, error.code == NSURLErrorNotConnectedToInternet {
    //                    return (.notConnectedToInternet)
    //                }
    //                return (.failure(Error(statusCode: 0, message: "Something Went Wrong")))
    //        }
    //
    //        switch statusCode {
    //        case 200:
    //            return (MovieWebServiceResponse.success(T(json: value)))
    //        case 401, 404:
    //            return (MovieWebServiceResponse.failure(ErrorData(json: value)))
    //        default:
    //            return (MovieWebServiceResponse.failure(ErrorData(statusCode: 0, message: "Something Went Wrong")))
    //        }
    //    }
}

