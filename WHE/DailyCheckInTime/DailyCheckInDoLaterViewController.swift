//
//  DailyCheckInDoLaterViewController.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 14/04/23.
//

import UIKit

class DailyCheckInDoLaterViewController: UIViewController {
  
  @IBOutlet weak var rewardsView: UIView!
  @IBOutlet weak var blureView: UIView!
  @IBOutlet weak var rewardsSkipButtonOutlet: UIButton!
  @IBOutlet weak var rewardsButtonOutlet: UIButton!
  @IBOutlet weak var rewardsImageIcon: UIImageView!
  @IBOutlet weak var rewardsDescriptionLabel: UILabel!
  @IBOutlet weak var rewardsHeaderLabel: UILabel!
  @IBOutlet weak var doLaterDescriptionLabel: UILabel!
  @IBOutlet weak var doLaterHeaderLabel: UILabel!
  let viewModel = DailyCheckInDoLaterViewModel()
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpLineHeightMultiple()
    iconColourChange()
    BGOverLayer()
    setUpButtonColour()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return self.style
  }
  
  var style:UIStatusBarStyle = .lightContent
  
  
  func setUpLineHeightMultiple() {
    doLaterHeaderLabel.attributedText = doLaterHeaderLabel.updateLineHeightMultipleLabel(with: doLaterHeaderLabel.text ?? "", lineHeight: viewModel.headerLineHeight)
    doLaterDescriptionLabel.attributedText = doLaterDescriptionLabel.updateLineHeightMultipleLabel(with: doLaterDescriptionLabel.text ?? "", lineHeight: viewModel.descriptionLineHeight)
    
    rewardsHeaderLabel.attributedText = rewardsHeaderLabel.updateLineHeightMultipleLabel(with: rewardsHeaderLabel.text ?? "", lineHeight: viewModel.rewardsHeaderHeight)
    rewardsDescriptionLabel.attributedText = rewardsDescriptionLabel.updateLineHeightMultipleLabel(with: rewardsDescriptionLabel.text ?? "", lineHeight: viewModel.rewardsDescriptionHeight)
    rewardsHeaderLabel.textAlignment = .center
    doLaterHeaderLabel.textAlignment = .center
    rewardsDescriptionLabel.textAlignment = .center
    doLaterDescriptionLabel.textAlignment = .center
  }
  
  func setUpButtonColour() {
    rewardsButtonOutlet.backgroundColor = AnthemColor.textBorderColor
    rewardsSkipButtonOutlet.titleLabel?.textColor =  AnthemColor.colonLabelColor
  }
  
  func BGOverLayer() {
    self.blureView.backgroundColor = UIColor(patternImage: UIImage(named: viewModel.bgOverlay)!)
    self.rewardsView.backgroundColor = AnthemColor.HighlightedCircleBorderColor
    
  }
  
  
  func iconColourChange() {
    rewardsImageIcon.image = UIImage(named: viewModel.starImg)?.withTintColor(AnthemColor.highLightedDateTextColor)
  }
  
  
  @IBAction func rewardsSkipButtonAction(_ sender: Any) {
    if let YourWeeklyPlanVC = WeeklyPlantSB.instantiateViewController(withIdentifier: "YourWeeklyPlanViewController") as? YourWeeklyPlanViewController {
      LocalStorageManager.setWillDoLaterChckIn(status: true)
      self.navigationController?.pushViewController(YourWeeklyPlanVC, animated: true)
    }
  }
  
  @IBAction func rewardsButtonAction(_ sender: Any) {
    LocalStorageManager.setWillDoLaterChckIn(status: false)
    self.navigationController?.popViewController(animated: true)
  }
}
