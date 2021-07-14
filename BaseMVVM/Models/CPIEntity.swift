//
//  CPIEntity.swift
//  BaseMVVM
//
//  Created by Quan on 14/07/2021.
//  Copyright © 2021 thoson.it. All rights reserved.
//

import Foundation

import Foundation
import ObjectMapper

class CPIEntity: Mappable {
    var data: [DataEntity] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class DataEntity: Mappable {
    var name: String = ""
    var value: [Double] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name    <- map["name"]
        value   <- map["value"]
    }
}
