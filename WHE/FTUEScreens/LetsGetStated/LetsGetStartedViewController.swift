//
//  LetsGetStartedViewController.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 23/02/23.
//

import UIKit

class LetsGetStartedViewController: UIViewController {

  @IBOutlet weak var getStartedTableviewHeight: NSLayoutConstraint!
  @IBOutlet weak var getReadyLabelConstarain: NSLayoutConstraint!
  @IBOutlet weak var getStartedButtonOutlet: UIButton!
  @IBOutlet weak var headerDescriptionLabel: UILabel!
  @IBOutlet weak var getStartedTableview: UITableView!
  @IBOutlet weak var headerTitleLabel: UILabel!
  @IBOutlet weak var scrollInterViewBG: UIView!
  @IBOutlet weak var scrollViewBG: UIScrollView!  
  let viewModel = LetsStartedViewModel()
 
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.isNavigationBarHidden = true
    applyButtonCornerRadius()
    tableViewRegisterNib()
    dynamicTableviewHeight()
    applyColourForButton()
    applyViewBGColour()
    labelMultipler()
    getScreenHeight()
   }
  
  func getScreenHeight() {
    let screenHeight = UIScreen.main.bounds.height
    if screenHeight <= getStartedButtonOutlet.frame.maxY {
      self.getReadyLabelConstarain.constant = 20
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    .lightContent
  }
  
  func applyColourForButton() {
    getStartedButtonOutlet.backgroundColor = AnthemColor.colorFromHex("794CFF")
  }
  
  func applyViewBGColour() {
    self.view.backgroundColor = AnthemColor.colorFromHex("231E33")
    self.scrollViewBG.backgroundColor = AnthemColor.colorFromHex("231E33")
    scrollInterViewBG.backgroundColor = AnthemColor.colorFromHex("231E33")
    self.getStartedTableview.backgroundColor = AnthemColor.colorFromHex("231E33")
  }

  func labelMultipler() {
    self.headerTitleLabel.attributedText = headerTitleLabel.updateLineHeightMultipleLabel(with: headerTitleLabel.text ?? "", lineHeight: 1.14)
  }
  func dynamicTableviewHeight() {
    getStartedTableviewHeight.constant = getStartedTableview.getStartedContentSizeHeight

  }
  func tableViewRegisterNib() {
    getStartedTableview.register(UINib(nibName: "GetStartedTableViewCell", bundle: nil), forCellReuseIdentifier: "GetStartedTableViewCell")
  }
  
  func applyButtonCornerRadius() {
    getStartedButtonOutlet.layer.cornerRadius = 10
  }
  
  @IBAction func getStartedButtonAction(_ sender: Any) {
    LocalStorageManager.setLetsGetStarted(status: true)
      let vc = PrivacySB.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
      self.navigationController?.pushViewController(vc, animated: true)
   
  }
  
}

extension LetsGetStartedViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getTableviewCellCount()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "GetStartedTableViewCell", for: indexPath) as! GetStartedTableViewCell
    cell.loadCell = true
    cell.headerTitleLabel.text = viewModel.getStartIndexArray[(indexPath.row)]
    var number = indexPath.row
    number += 1
    cell.indexLabel.text =   "\(number)"
    cell.imagviewHeight.constant = CGFloat(viewModel.imagviewHeightIndex[indexPath.row])
     cell.indexImage.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
    cell.indexImage.image = UIImage(named: viewModel.onBoardingImages[indexPath.row])
    cell.headerTitleLabel.attributedText = headerTitleLabel.updateLineHeightMultipleLabel(with: viewModel.getStartIndexArray[indexPath.row], lineHeight: 1.24)
    return cell
  }
  
  func imageWidthAspectRatio(image: UIImageView, indexValue: Int) -> CGFloat {
    let ratio = image.frame.size.width / CGFloat(viewModel.imagviewHeightIndex[indexValue])
    let newHeight = image.frame.width / ratio
    return newHeight
  }
  
  
}

extension UITableView {
  var getStartedContentSizeHeight: CGFloat {
    var height = CGFloat(0)
    for section in 0..<numberOfSections {
      height = height + rectForHeader(inSection: section).height
      let rows = numberOfRows(inSection: section)
      for row in 0..<rows {
        height = height + rectForRow(at: IndexPath(row: row, section: section)).height
      }
    }
    return height
  }
}
