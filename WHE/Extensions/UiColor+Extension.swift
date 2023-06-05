//
//  UiColor+Extension.swift
//  WHE
//
//  Created by Pratima Pundalik on 19/01/23.
//

import UIKit
extension UIColor {
    convenience init(hexString: String) {

                let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)

                var rgbValue = UInt64()

                Scanner(string: hex).scanHexInt64(&rgbValue)

                let a, r, g, b: UInt64

                switch hex.count {

                case 3: // RGB (12-bit)

                    (a, r, g, b) = (255, (rgbValue >> 8) * 17, (rgbValue >> 4 & 0xF) * 17, (rgbValue & 0xF) * 17)

                case 6: // RGB (24-bit)

                    (a, r, g, b) = (255, rgbValue >> 16, rgbValue >> 8 & 0xFF, rgbValue & 0xFF)

                case 8: // ARGB (32-bit)

                    (a, r, g, b) = (rgbValue >> 24, rgbValue >> 16 & 0xFF, rgbValue >> 8 & 0xFF, rgbValue & 0xFF)

                default:

                    (a, r, g, b) = (255, 0, 0, 0)

                }

                self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)

            }

}


