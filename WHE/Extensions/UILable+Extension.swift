//
//  UILable+Extension.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 10/02/23.
//

import Foundation
import UIKit

extension UILabel {

  func updateLineHeightMultipleLabel(with title: String, lineHeight: CGFloat = 1.5) -> NSAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = lineHeight
    paragraphStyle.alignment = .left
    return NSAttributedString(string: title, attributes: [.paragraphStyle: paragraphStyle])
  }
}
