//
//  ActivityViewController.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 19/01/23.
//

import UIKit

class ActivityViewController: UIViewController {
  
  @IBOutlet weak var activityCurveView: UIView!
  override func viewDidLoad() {
    super.viewDidLoad()
    applyBGColorCornerRadius()
  }
  
  func applyBGColorCornerRadius() {
    view.backgroundColor = AnthemColor.tabBarDarkGrayColour
    activityCurveView.layer.cornerRadius = 45
  }
  
}
