//
//  LoaderErrorBaseViewController.swift
//  WHE
//
//  Created by Pratima Pundalik on 23/01/23.
//

import UIKit

class LoaderErrorBaseViewController: UIViewController {
   @IBOutlet weak var spinnerBGView: UIView!
  @IBOutlet weak var spinnerImageView: UIImageView!
  @IBOutlet weak var spinnerRetrievingLabel: UILabel!
  var count = 1
  var fromMedsScreen : Bool = false
  @IBOutlet weak var tryAgainView: UIView!
  @IBOutlet weak var tryAgainButton: UIButton!
  weak var delegate: AddMedsDetailProtocal?
    
    var isSpinnerHidden = true
  override func viewDidLoad() {
    super.viewDidLoad()
      applyRoundCorners()
      showLoader(isHidden: false)
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          self.showLoader(isHidden: true)
          self.showAddMeds()
      }
  }
  
  @IBAction func dismissErrorScreen(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    
  }
  
  func addMedsView() {
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    if let loaderErrorViewController = storyboard.instantiateViewController(withIdentifier: "AddMedsViewController") as? AddMedsViewController {
      loaderErrorViewController.fromMedsScreen = fromMedsScreen
      self.navigationController?.pushViewController(loaderErrorViewController, animated: true)
    }
  }
  
  func applyRoundCorners() {
    self.view.backgroundColor = AnthemColor.errorBackGroundColor
    self.view.layer.cornerRadius = 45
  }
  
  
  @IBAction func tryAgainAction(_ sender: Any) {
    self.spinnerBGView.isHidden = false
    roatateImageView()
  }
    
    func showErrorScreen(isHidden: Bool) {
        self.tryAgainView.isHidden = isHidden
        tryAgainButton.backgroundColor = AnthemColor.tryAgainBackGroundColor
        tryAgainButton.layer.cornerRadius = 10
    }
    
    func showAddMeds() {
        addMedsView()
    }
    
    func showLoader(isHidden: Bool) {
        isSpinnerHidden = isHidden
        self.spinnerBGView.isHidden = isHidden
        if !isHidden {
            roatateImageView()
        }
    }
    
    func roatateImageView() {
      UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {() in
        self.spinnerImageView.transform = self.spinnerImageView.transform.rotated(by: CGFloat(Double.pi / 2))
      },completion: {(completed) in
          if completed && !self.isSpinnerHidden {
              self.roatateImageView()
          }
        
      })
    }
}
