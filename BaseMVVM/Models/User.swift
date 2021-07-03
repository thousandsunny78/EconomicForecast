//
//  User.swift
//  BaseMVVM
//
//  Created by Trần Hồng Quân on 1/5/20.
//  Copyright © 2020 quanth. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var id: Int = 0
    var avatarUrl : String = ""
    var name: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id                  <- map["id"]
        avatarUrl           <- map["avatar_url"]
        name                <- map["name"]
    }
}
