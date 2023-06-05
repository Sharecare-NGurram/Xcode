//
//  ActivityIndicator.swift
//  WHE
//
//  Created by Rajesh Gaddam on 29/03/23.
//

import Foundation
import UIKit

class ActivityIndicator {
   static var container: UIView = UIView()
   static var loadingView: UIView = UIView()
   static var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static var loadingImage : UIImageView = UIImageView()
  static func showActivityIndicator(uiView: UIView, fromTabBar: Bool = false) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9803921569, blue: 0.9843137255, alpha: 0.6025803257)
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9803921569, blue: 0.9843137255, alpha: 0.6025803257)
    if fromTabBar {
      container.layer.cornerRadius = 65
    }
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        loadingImage.frame = CGRect(x: 0.0, y: 0.0, width: 65.0, height: 65.0);
        loadingImage.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);
        loadingImage.image = UIImage(named: "spinner")
        loadingView.addSubview(loadingImage)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        roatateImageView()
    }
    
   static func hideActivityIndicator(uiView: UIView) {
        container.removeFromSuperview()
    }
    
    static func roatateImageView() {
      UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {() in
        self.loadingImage.transform = self.loadingImage.transform.rotated(by: CGFloat(Double.pi / 2))
      },completion: {(completed) in
          if completed {
              self.roatateImageView()
          }
      })
    }
}
