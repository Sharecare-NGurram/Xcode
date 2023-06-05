//
//  CareViewController.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 16/01/23.
//

import UIKit

class CareViewController: UIViewController {
  
  @IBOutlet weak var careCurveView: UIView!
  override func viewDidLoad() {
    super.viewDidLoad()
    applyBGColorCornerRadius()
  }
  
  func applyBGColorCornerRadius() {
    view.backgroundColor = AnthemColor.tabBarDarkGrayColour
    careCurveView.layer.cornerRadius = 45
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
