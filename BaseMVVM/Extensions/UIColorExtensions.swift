//
//  UIColorExtensions.swift
//  BaseMVVM
//
//  Created by Trần Hồng Quân on 1/4/20.
//  Copyright © 2020 quanth. All rights reserved.
//

import UIKit

// MARK: Constant
public extension UIColor {
    static let main = UIColor(named: "mainColor")
    static let navigation = UIColor(named: "navigationColor")
    static let background = UIColor(named: "backgroundColor")
    static let text = UIColor(named: "textColor")
    static let separator = UIColor(named: "separatorColor")
    static let lightText = UIColor(named: "lightColor")
    static let lighterText = UIColor(named: "lighterColor")
    static let darkText = UIColor(named: "mainColor")
}

// MARK: - Properties
public extension UIColor {
    /// Hexadecimal value string (read-only).
    var hexString: String {
        let components: [Int] = {
            let comps = cgColor.components!
            let components = comps.count == 4 ? comps : [comps[0], comps[0], comps[0], comps[1]]
            return components.map { Int($0 * 255.0) }
        }()
        return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
    }
}

// MARK: - Initializers
public extension UIColor {
    /// Create Color from RGB values with optional transparency.
    ///
    /// - Parameters:
    ///   - red: red component.
    ///   - green: green component.
    ///   - blue: blue component.
    ///   - transparency: optional transparency value (default is 1).
    convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }
        
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
    
    /// SwifterSwift: Create Color from hexadecimal value with optional transparency.
    ///
    /// - Parameters:
    ///   - hex: hex Int (example: 0xDECEB5).
    ///   - transparency: optional transparency value (default is 1).
    convenience init?(hex: Int, transparency: CGFloat = 1) {
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        let red = (hex >> 16) & 0xff
        let green = (hex >> 8) & 0xff
        let blue = hex & 0xff
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }
}

// MARK: - Social
public extension UIColor {
    
    /// Brand identity color of popular social media platform.
    struct App {
        private init() {}
        
        /// red: 59, green: 89, blue: 152
        public static let facebook = UIColor(red: 59, green: 89, blue: 152)!
        
        /// red: 0, green: 182, blue: 241
        public static let twitter = UIColor(red: 0, green: 182, blue: 241)!
        
        public static let tabUnselected = UIColor(red: 229, green: 240, blue: 246)!
        public static let tabSelected = UIColor(red: 0, green: 68, blue: 129)!
        
        public static let xhakar = UIColor(red: 248, green: 0, blue: 26)!
        public static let toreira = UIColor(red: 18, green: 119, blue: 22)!
        public static let ozil = UIColor(red: 76, green: 171, blue: 206)!
        public static let ramsey = UIColor(red: 247, green: 137, blue: 58)!
        public static let laca = UIColor(red: 24, green: 115, blue: 185)!
        public static let auba = UIColor(red: 33, green: 33, blue: 33)!
    }
    
}

