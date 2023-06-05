//
//  TakeYourMedsViewController.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 14/04/23.
//

import UIKit

class TakeYourMedsViewController: UIViewController {

  @IBOutlet weak var headerLabelText: UILabel!
  @IBOutlet weak var closeButtonOutlet: UIButton!
  @IBOutlet weak var popUpVIew: UIView!
  @IBOutlet weak var blureView: UIView!
//  var delegate: TakeYourMedsProtocal? = nil
  let viewModel = TakeYourMedsViewModel()
  override func viewDidLoad() {
        super.viewDidLoad()
    setMainBackground()
//    popUpVIewBackGround()
    closeButtonOutlet.setImage(UIImage(named: "close")?.withTintColor(.white), for: .normal)
    self.headerLabelText.attributedText = headerLabelText.updateLineHeightMultipleLabel(with: headerLabelText.text ?? "", lineHeight: viewModel.lineHeight)
    self.headerLabelText.textAlignment = .center
  }
    
  func setMainBackground() {
    self.blureView.backgroundColor = UIColor(patternImage: UIImage(named: viewModel.bgOverlay)!)
   }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return self.style
  }
  @IBAction func closeButtonAction(_ sender: Any) {
      self.dismiss(animated: true)
  }
  
  var style:UIStatusBarStyle = .lightContent
  
  func popUpVIewBackGround() {
    self.popUpVIew.backgroundColor = UIColor(patternImage: UIImage(named: viewModel.yourMedsTodayBGImg)!)
  }
  
  @IBAction func stackViewButtonActions(_ sender: UIButton) {
    if sender.tag == viewModel.noneButtonTag {
  //    delegate?.passValue(labelText: "None")
        self.dismiss(animated: true)
    } else if sender.tag == viewModel.someButtonTag {
    //  delegate?.passValue(labelText: "")
        self.dismiss(animated: true)
    } else if sender.tag == viewModel.allButtonTag {
      print("action ")
        self.dismiss(animated: true)
    }
  }
  
}
