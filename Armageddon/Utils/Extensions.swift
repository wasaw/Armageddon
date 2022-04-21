//
//  Extensions.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/18/22.
//

import UIKit

//  MARK: - UIColor

extension UIColor {
    static let navigationBackground = UIColor(displayP3Red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
    static let buttonBackground = UIColor(displayP3Red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
    static let safeAsteroidStartGradient = UIColor(displayP3Red: 207/255, green: 243/255, blue: 125/255, alpha: 1)
    static let safeAsteroidFinishGradient = UIColor(displayP3Red: 125/255, green: 232/255, blue: 140/255, alpha: 1)
    static let dangerousAsteroidStartGradient = UIColor(displayP3Red: 255/255, green: 177/255, blue: 153/255, alpha: 1)
    static let dangerousAsteroidFinishGradient = UIColor(displayP3Red: 255/255, green: 8/255, blue: 68/255, alpha: 1)
    static let cellShadowBackground = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.987)
}

//MARK: - String

extension String {
    func substring(from left: String, to right: String) -> String {
        if let match = range(of: "(?<=\(left))[^\(right)]+", options: .regularExpression) {
            return String(self[match])
        }
        return ""
    }
    
    func separated(by separator: String = " ", stride: Int = 3) -> String {
           return enumerated().map { $0.isMultiple(of: stride) && ($0 != 0) ? "\(separator)\($1)" : String($1) }.joined()
       }
}
