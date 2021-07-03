//
//  LogManager.swift
//  BaseMVVM
//
//  Created by Trần Hồng Quân on 3/29/20.
//  Copyright © 2020 quanth. All rights reserved.
//

import Foundation
import SwiftyBeaver

let log = SwiftyBeaver.self

//Can use Logger replace for SwiftyBeaver
private class Logger {
    class func verbose() {}
    class func debug() {}
    class func info() {}
    class func warning() {}
    class func error() {}
}
