//
//  GendreTest.swift
//  Movies
//
//  Created by Jaime Laino on 7/1/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

import XCTest
@testable import Movies

class GendreTest: XCTestCase {
    
    func testGendreData() {
        let gendreName = "Test Name"
        let gendre : Gendre = GendreData(id: "21",
                                         name: gendreName)
        
        XCTAssertEqual(gendre.name, gendreName)
    }
    
}
