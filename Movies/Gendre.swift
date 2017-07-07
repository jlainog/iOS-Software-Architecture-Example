//
//  Gendre.swift
//  Movies
//
//  Created by Jaime Laino on 7/1/17.
//  Copyright © 2017 JLainoG. All rights reserved.
//

protocol Gendre {
    var id : String { get }
    var name : String { get }
}

struct GendreData : Gendre {
    let id : String
    let name : String
}
