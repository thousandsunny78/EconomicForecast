//
//  Token.swift
//  BaseMVVM
//
//  Created by Trần Hồng Quân on 4/25/20.
//  Copyright © 2020 quanth. All rights reserved.
//

import Foundation
import ObjectMapper

struct Token: Mappable {
    var accessToken: String?
    var refreshToken: String?
    
    init?(map: Map) {}
    init() {}
    
    mutating func mapping(map: Map) {
        accessToken         <- map["access_token"]
        refreshToken        <- map["refresh_token"]
    }
}
