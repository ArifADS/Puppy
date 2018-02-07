//
//  Response.swift
//  Puppy
//
//  Created by Arif De Sousa on 2/7/18.
//  Copyright © 2018 arifads. All rights reserved.
//

import Foundation

class Response: Decodable {
    let results: [QueryResult]
}
