//
//  ChartControlEntity.swift
//  BaseMVVM
//
//  Created by Quan on 13/07/2021.
//  Copyright © 2021 thoson.it. All rights reserved.
//

import Foundation
import ObjectMapper

class ChartControlEntity: Mappable {
    var color: UIColor = UIColor.red
    var content: String = "no title"
    var isOn: Bool = false
    
    required init?(color: UIColor, content: String, isOn: Bool) {
        self.color = color
        self.content = content
        self.isOn = isOn
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        isOn    <- map["isOn"]
        content <- map["content"]
        color   <- map["color"]
    }
}
