//
//  UIFont+Extension.swift
//  WHE
//
//  Created by Pratima Pundalik on 31/01/23.
//

import UIKit
extension UIFont {
    static func semiBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "ElevanceSans-Semibold", size: size) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    static func mediumBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "ElevanceSans-Medium", size: size) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
}
