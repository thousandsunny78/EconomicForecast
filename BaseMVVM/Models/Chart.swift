//
//  Repository.swift
//  BaseMVVM
//
//  Created by Trần Hồng Quân on 1/5/20.
//  Copyright © 2020 quanth. All rights reserved.
//

import Foundation
import ObjectMapper

class Chart: Mappable {
    var id: String = ""
    var name: String = ""
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id                  <- map["id"]
        name                <- map["title"]
    }
}
