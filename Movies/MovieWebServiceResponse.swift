//
//  MovieWebServiceResponse
//  Movies
//
//  Created by Jaime Laino on 7/13/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import Foundation

protocol Parseable {
    init(json: NSDictionary)
}

enum MovieWebServiceResponse<Value: Parseable> {
    case failure(ErrorData)
    case notConnectedToInternet
    case success(Value)
}

struct ErrorData {
    let statusCode : Int
    let message : String
    
    init(json: NSDictionary) {
        self.statusCode = json["status_code"] as? Int ?? 0
        self.message = json["status_message"] as? String ?? ""
    }
    
    init(statusCode: Int, message: String) {
        self.statusCode = statusCode
        self.message = message
    }
}
