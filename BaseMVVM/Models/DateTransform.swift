//
//  ISO8601DateTransform.swift
//  BaseMVVM
//
//  Created by Trần Hồng Quân on 4/25/20.
//  Copyright © 2020 quanth. All rights reserved.
//

import Foundation
import ObjectMapper

class DateTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String {
            return Date(iso8601String: dateString)
        }
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return date.iso8601String
        }
        return nil
    }
}
