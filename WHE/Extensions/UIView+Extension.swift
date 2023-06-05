//
//  UIView+Extension.swift
//  ShareCareTabBar
//
//  Created by Venkateswarlu Samudrala on 12/01/23.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
@IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func roundCorners(corner: UIRectCorner = [.bottomRight, .bottomLeft], radius: CGFloat = 40) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func dropShadowWithCornerRaduis() {
        layer.masksToBounds = true
        layer.shadowColor = AnthemColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
    }
  

        enum ViewSide {
            case top
            case left
            case bottom
            case right
        }

        func addBorders(to sides: [ViewSide], in color: UIColor, width: CGFloat) {
            sides.forEach { addBorder(to: $0, in: color, width: width) }
        }

        func addBorder(to side: ViewSide, in color: UIColor, width: CGFloat) {
            switch side {
            case .top:
                addTopBorder(in: color, width: width)
            case .left:
                addLeftBorder(in: color, width: width)
            case .bottom:
                addBottomBorder(in: color, width: width)
            case .right:
                addRightBorder(in: color, width: width)
            }
        }
    func addTopBorder(in color: UIColor?, width borderWidth: CGFloat) {
           let border = UIView()
           border.backgroundColor = color
           border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
           border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
           addSubview(border)
       }

       func addBottomBorder(in color: UIColor?, width borderWidth: CGFloat) {
           let border = UIView()
           border.backgroundColor = color
           border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
           border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
           addSubview(border)
       }

       func addLeftBorder(in color: UIColor?, width borderWidth: CGFloat) {
           let border = UIView()
           border.backgroundColor = color
           border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
           border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
           addSubview(border)
       }

       func addRightBorder(in color: UIColor?, width borderWidth: CGFloat) {
           let border = UIView()
           border.backgroundColor = color
           border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
           border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
           addSubview(border)
       }
}
