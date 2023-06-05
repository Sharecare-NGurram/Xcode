//
//  UIViewController+Extension.swift
//  WHE
//
//  Created by Pratima Pundalik on 24/01/23.
//

import UIKit
extension UIViewController {
  func showToast(message : String, fontSize: CGFloat = 16.0) {
    let toastLabel = UILabel(frame: CGRect(x: self.view.center.x - 125 , y: 64, width: 250, height: 44))
    toastLabel.backgroundColor = UIColor(red: 74/255, green: 165/255, blue: 100/255, alpha: 1.0)
    toastLabel.textColor = UIColor.white
    toastLabel.font = UIFont.semiBold(ofSize: 16)
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10
    toastLabel.clipsToBounds = true
    self.view.addSubview(toastLabel)
    DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
      toastLabel.removeFromSuperview()
    }
  }
  
  //MARK:- Alert with completion handler
  func showAlertOnWindow(title: String? = nil, message: String? = nil, titles: [String] = ["OK"], completionHanlder: ((_ title: String) -> Void)? = nil) {
    
    let alert = UIAlertController(title: title ?? "", message: message, preferredStyle: UIAlertController.Style.alert)
    for title in titles {
      alert.addAction(UIAlertAction(title: title, style: UIAlertAction.Style.default, handler: { (action) in
        completionHanlder?(title)
      }))
    }
    present(alert, animated: true, completion: nil)
  }
  
  func showAlertWindow(title: String? = nil, message: String? = nil, titles: [String] = ["OK"], styleType: Bool = false, completionHanlder: ((_ title: String) -> Void)? = nil) {
    let alert = UIAlertController(title: title ?? "", message: message, preferredStyle: UIAlertController.Style.alert)
    if styleType {
      for title in titles {
        alert.addAction(UIAlertAction(title: title, style: UIAlertAction.Style.default, handler: { (action) in
          completionHanlder?(title)
        }))
      }
    } else {
      for title in titles {
        if title.lowercased() == "cancel" {
          alert.addAction(UIAlertAction(title: title, style: UIAlertAction.Style.default, handler: { (action) in
            completionHanlder?(title)
          }))
        }else {
          alert.addAction(UIAlertAction(title: title, style: UIAlertAction.Style.destructive, handler: { (action) in
            completionHanlder?(title)
          }))
        }
      }
    }
    present(alert, animated: true, completion: nil)
  }
    
    func showErrorAlertWIthBlurEffect(retryHandler: @escaping () -> Void ) {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds
        
        let alertController = UIAlertController.init(title: ErrorContent.kTitle, message: ErrorContent.kMessage, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (action: UIAlertAction!) in
            blurVisualEffectView.removeFromSuperview()
            retryHandler()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
            blurVisualEffectView.removeFromSuperview()
        }))
        self.view.addSubview(blurVisualEffectView)
        self.present(alertController, animated: true, completion: nil)
    }
}

struct Alert {
  static func showAlert(on vc:UIViewController, with title: String, message: String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    vc.present(alert, animated: true, completion: nil)
  }
}


