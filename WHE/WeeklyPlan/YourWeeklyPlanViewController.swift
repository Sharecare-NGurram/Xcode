//
//  YourWeeklyPlanViewController.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 06/04/23.
//

import UIKit

class YourWeeklyPlanViewController: UIViewController {
  
  @IBOutlet weak var continueButtonOutlet: UIButton!
  @IBOutlet weak var addMedicationLabelText: UILabel!
  @IBOutlet weak var yourWeeklyPlanHeaderLabel: UILabel!
  
  @IBOutlet weak var goToHealthSettingOutlet: UIButton!
  
  @IBOutlet weak var addMedicationsButtonOutlet: UIButton!
  @IBOutlet weak var yourWeeklyPlanDescriptionLabel: UILabel!
  @IBOutlet weak var addMedicationsView: UIView!
  @IBOutlet weak var goToSettingView: UIView!
  @IBOutlet weak var gotoSettingLabelTralingSpace: NSLayoutConstraint!
  @IBOutlet weak var gotoSettingLinkImageWidth: NSLayoutConstraint!
  @IBOutlet weak var gotoSettingLabelText: UILabel!
  @IBOutlet weak var gotoSettingLinkImg: UIImageView!
  @IBOutlet weak var spinnerImageView: UIImageView!
  @IBOutlet weak var stepsSucessImg: UIImageView!
  @IBOutlet weak var stepsHeaderTitle: UILabel!
  @IBOutlet weak var stepsRadioButtonOutlet: UIButton!
  @IBOutlet weak var stepsDescriptionTitle: UILabel!
  @IBOutlet weak var trackStepsImageLabelView: UIView!
  @IBOutlet weak var automaticallyTrackerTitle: UILabel!
  
  @IBOutlet weak var trackMedsHeaderTitle: UILabel!
  @IBOutlet weak var trackMedsDescriptionTitle: UILabel!
  @IBOutlet weak var trackerMedsRadioButtonOutlet: UIButton!
  
  @IBOutlet weak var trackMedsImageLabelView: UIView!
  @IBOutlet weak var manuallyTrackerTitle: UILabel!
  
  @IBOutlet weak var footerBgView: UIView!
  @IBOutlet weak var footerHeaderTitle: UILabel!
  
  @IBOutlet weak var dailyCheckInDescriptionTitle: UILabel!
  @IBOutlet weak var dailyCheckinHeaderTitle: UILabel!
  @IBOutlet weak var checkInTimeButtonOutlet: UIButton!
  
  var isSpinnerHidden = true
  let viewModel = YourWeeklyPlanViewModel()
  let permissionsHealthKitViewModel = HealthKitPermissionsViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
  }
  
  func notificationCenterAddObserverFocusArea() {
    NotificationCenter.default.addObserver(self, selector: #selector(self.updateYourWeeklyPlan), name: UIApplication.didBecomeActiveNotification, object: nil)
  }
  
  @objc func updateYourWeeklyPlan() {
    verifyTrackerYourMedsStatus()
    verifyPermissionStatusForYourSteps()
    verifyCheckInStatus()
  }
  
  func trackMedsSetup() {
    self.trackMedsHeaderTitle.attributedText = trackMedsHeaderTitle.updateLineHeightMultipleLabel(with: trackMedsHeaderTitle.text ?? "", lineHeight: viewModel.headerLineHeight)
    self.trackMedsDescriptionTitle.attributedText = trackMedsDescriptionTitle.updateLineHeightMultipleLabel(with:trackMedsDescriptionTitle.text ?? "", lineHeight: viewModel.descriptionLineHeight)
    addMedicationLabelText.textColor = AnthemColor.buttonTextColor
  }
  
  func trackerYourStepsSetup() {
    self.stepsHeaderTitle.attributedText = stepsHeaderTitle.updateLineHeightMultipleLabel(with: stepsHeaderTitle.text ?? "", lineHeight: viewModel.headerLineHeight)
    self.stepsDescriptionTitle.attributedText = stepsDescriptionTitle.updateLineHeightMultipleLabel(with:stepsDescriptionTitle.text ?? "", lineHeight: viewModel.descriptionLineHeight)
    gotoSettingLinkImg.image = UIImage(named: viewModel.gotoSettingLinkImg)?.withTintColor(AnthemColor.textBorderColor)
    gotoSettingLabelText.textColor = AnthemColor.buttonTextColor
  }
  
  func yourWeeklyPlanHeaderSetup() {
    self.yourWeeklyPlanDescriptionLabel.attributedText = yourWeeklyPlanDescriptionLabel.updateLineHeightMultipleLabel(with: yourWeeklyPlanDescriptionLabel.text ?? "", lineHeight: viewModel.descriptionLineHeight)
    self.yourWeeklyPlanHeaderLabel.attributedText = yourWeeklyPlanHeaderLabel.updateLineHeightMultipleLabel(with: yourWeeklyPlanHeaderLabel.text ?? "", lineHeight: viewModel.headerLineHeight)
    showLoader(isHidden: true)
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    footerSetup()
    trackMedsSetup()
    trackerYourStepsSetup()
    notificationCenterAddObserverFocusArea()
    verifyPermissionStatusForYourSteps()
    verifyTrackerYourMedsStatus()
    verifyCheckInStatus()
    yourWeeklyPlanHeaderSetup()
    setUpButtonColour()
  }
  
  func verifyTrackerYourMedsStatus() {
    if LocalStorageManager.fetchMedicineSaved() {
      addMedicationsView.isHidden = true
      addMedicationsButtonOutlet.isHidden = true
      trackMedsImageLabelView.isHidden = false
       trackerMedsRadioButtonOutlet.setImage(UIImage(named: viewModel.radioButtonTickMarkImage)?.withTintColor(AnthemColor.completedStatusColor), for: .normal)
      trackMedsDescriptionTitle.text = viewModel.sharingAuthorizedMeds
      self.trackerMedsRadioButtonOutlet.isUserInteractionEnabled = true
    } else if LocalStorageManager.fetchTrackMedicinesNotRightNow() {
      self.trackerMedsRadioButtonOutlet.isUserInteractionEnabled = true
      addMedicationsButtonOutlet.isHidden = false
      trackerMedsRadioButtonOutlet.setImage(UIImage(named: viewModel.radioButtonTickMarkImage)?.withTintColor(AnthemColor.completedStatusColor), for: .normal)
      trackMedsSkipNotCompleted()
    } else {
      self.trackerMedsRadioButtonOutlet.isUserInteractionEnabled = false
      trackerMedsRadioButtonOutlet.setImage(UIImage(named: viewModel.radioButtonUnTickMarkImage)?.withTintColor(AnthemColor.resendGrayColor.withAlphaComponent(0.15)), for: .normal)
      trackMedsSkipNotCompleted()
      addMedicationsButtonOutlet.isHidden = false
    }
    trackMedsSetup()
  }
  
  func trackMedsSkipNotCompleted() {
    addMedicationsView.isHidden = false
    trackMedsImageLabelView.isHidden = true
    trackMedsDescriptionTitle.text = viewModel.sharingSkippedMeds
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return self.style
  }
  
  var style:UIStatusBarStyle = .default
  
  func showLoader(isHidden: Bool) {
    spinnerImageView.isHidden = isHidden
    isSpinnerHidden = isHidden
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
  
  func verifyCheckInStatus() {
    if LocalStorageManager.fetchDailyCheckIn() {
      dailyCheckInDescriptionTitle.text = viewModel.setupMyfirstWeekCheckIn
      checkInTimeButtonOutlet.setTitle(viewModel.setUpCheckInButton, for: .normal)
    } else if LocalStorageManager.fetchWillDoLaterChckIn() {
      dailyCheckInDescriptionTitle.text = viewModel.skipBonusDoLaterCheckIn
      checkInTimeButtonOutlet.setTitle(viewModel.skipCheckInButton, for: .normal)
    }
    if LocalStorageManager.fetchSkipCheckin() {
        checkInTimeButtonOutlet.setTitle(viewModel.skipCheckInButton, for: .normal)
    } else {
        checkInTimeButtonOutlet.setTitle(viewModel.setUpCheckInButton, for: .normal)
    }
    dailyCheckInDescriptionTitle.attributedText = dailyCheckInDescriptionTitle.updateLineHeightMultipleLabel(with: dailyCheckInDescriptionTitle.text ?? "" , lineHeight: viewModel.descriptionLineHeight)
      
    checkInTimeButtonOutlet.setTitleColor(AnthemColor.buttonTextColor, for: .normal)
  }
  
  func verifyPermissionStatusForYourSteps() {
    let status = permissionsHealthKitViewModel.healthKitAccess()
    switch status {
    case .sharingDenied:
      stepsDescriptionTitle.text = viewModel.sharingDeniedSteps
      stepsHeaderTitle.textColor = AnthemColor.rewardsTextColor
      stepsDescriptionTitle.textColor = AnthemColor.rewardsTextColor
       trackStepsImageLabelViewStatus(hidden: true)
      gotoSettingViewStatus()
      gotoSettingLinkImageWidth.constant = 22
      gotoSettingLinkImg.isHidden = false
      gotoSettingLabelTralingSpace.constant = 13
      goToSettingView.backgroundColor = AnthemColor.textBorderColor.withAlphaComponent(0.06)
      gotoSettingLabelText.textColor = AnthemColor.textBorderColor
      gotoSettingLabelText.text = viewModel.goToHealthSettingsText
      trackerYourStepsSetup()
      stepsRadioButtonOutlet.tag = viewModel.sharingDeniedStepsTag
      stepsRadioButtonOutlet.setImage(UIImage(named: viewModel.radioButtonUnTickMarkImage)?.withTintColor(AnthemColor.resendGrayColor.withAlphaComponent(0.15)), for: .normal)
      stepsRadioButtonOutlet.isUserInteractionEnabled = false
      self.goToHealthSettingOutlet.isHidden = false
      break
    case .sharingAuthorized:
      stepsDescriptionTitle.text = viewModel.sharingAuthorizedSteps
      stepsHeaderTitle.textColor = AnthemColor.enabledDateTextColor
      stepsDescriptionTitle.textColor = AnthemColor.DayTextColor
      gotoSettingViewStatus(hidden: true)
      trackStepsImageLabelViewStatus()
      trackerYourStepsSetup()
      stepsRadioButtonOutlet.setImage(UIImage(named: viewModel.radioButtonTickMarkImage)?.withTintColor(AnthemColor.completedStatusColor), for: .normal)
      stepsRadioButtonOutlet.isUserInteractionEnabled = true
      self.goToHealthSettingOutlet.isHidden = true
      break
    case .notDetermined:
      stepsDescriptionTitle.text = viewModel.sharingDeniedSteps
      stepsHeaderTitle.textColor = AnthemColor.submitBtnGrayColor
      stepsDescriptionTitle.textColor = AnthemColor.submitBtnGrayColor
      trackStepsImageLabelViewStatus(hidden: true)
      gotoSettingViewStatus()
      gotoSettingLabelText.text = viewModel.connecttoHealthAppText
      gotoSettingLabelText.textColor = AnthemColor.submitBtnWhiteColor
      gotoSettingLinkImageWidth.constant = 0
      gotoSettingLabelTralingSpace.constant = 2
      goToSettingView.backgroundColor = AnthemColor.colonLabelColor.withAlphaComponent(0.06)
      stepsRadioButtonOutlet.isUserInteractionEnabled = false
      self.goToHealthSettingOutlet.isHidden = false
      trackerYourStepsSetup()
      stepsRadioButtonOutlet.tag = viewModel.sharingNotDeterminedStepsTag
      stepsRadioButtonOutlet.setImage(UIImage(named: viewModel.radioButtonUnTickMarkImage)?.withTintColor(AnthemColor.resendGrayColor.withAlphaComponent(0.15)), for: .normal)
    default:
      break
    }
  }
  
  func trackStepsImageLabelViewStatus(hidden: Bool = false) {
    trackStepsImageLabelView.isHidden = hidden
  }
  
  func gotoSettingViewStatus(hidden: Bool = false) {
    goToSettingView.isHidden = hidden
  }
  
  func footerSetup() {
    self.footerBgView.backgroundColor = UIColor(patternImage: UIImage(named: viewModel.footerBGImage)!)
    footerHeaderTitle.attributedText = footerHeaderTitle.updateLineHeightMultipleLabel(with: footerHeaderTitle.text ?? "", lineHeight: viewModel.descriptionLineHeight)
  }
  
  // MARK: - Health-Kit Permission AlertView & read data
  func addHealthKitPermissionAlertView() {
    let status = permissionsHealthKitViewModel.healthKitAccess()
    switch status {
    case .notDetermined:
      if self.style == .lightContent {
        self.style = .default
      } else {
        self.style = .lightContent
      }
      setNeedsStatusBarAppearanceUpdate()
      showAlertWindow(title: permissionsHealthKitViewModel.permissionTitle, message: permissionsHealthKitViewModel.permissionMessage, titles: permissionsHealthKitViewModel.alertButtonTitles , styleType: true) { title in
        if title == self.permissionsHealthKitViewModel.alertButtonTitles[0] {
        } else {
          self.showLoader(isHidden: false)
          self.permissionsHealthKitViewModel.getAccess(completionHandler: {status in
            DispatchQueue.main.async {
              self.showLoader(isHidden: true)
              self.verifyPermissionStatusForYourSteps()
            }
          })
        }
        self.style = .default
        self.setNeedsStatusBarAppearanceUpdate()
      }
      break
    default:
      self.verifyPermissionStatusForYourSteps()
      break
    }
  }
  @IBAction func trackMedsRadioButtonAction(_ sender: Any) {
    if trackerMedsRadioButtonOutlet.currentImage == UIImage(named: viewModel.radioButtonTickMarkImage)?.withTintColor(AnthemColor.completedStatusColor) {
      trackerMedsRadioButtonOutlet.setImage(UIImage(named: viewModel.radioButtonUnTickMarkImage), for: .normal)
    }  else {
      trackerMedsRadioButtonOutlet.setImage(UIImage(named: viewModel.radioButtonTickMarkImage)?.withTintColor(AnthemColor.completedStatusColor), for: .normal)
    }
  }
  
  @IBAction func stepsRadioButtonAction(_ sender: Any) {
    if stepsRadioButtonOutlet.currentImage == UIImage(named: viewModel.radioButtonTickMarkImage)?.withTintColor(AnthemColor.completedStatusColor) {
      stepsRadioButtonOutlet.setImage(UIImage(named: viewModel.radioButtonUnTickMarkImage), for: .normal)
    } else {
      stepsRadioButtonOutlet.setImage(UIImage(named: viewModel.radioButtonTickMarkImage)?.withTintColor(AnthemColor.completedStatusColor), for: .normal)
    }
  }
  
  @IBAction func addMedicationsButtonAction(_ sender: Any) {
    ActivityIndicator.showActivityIndicator(uiView: self.view)
    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
      ActivityIndicator.hideActivityIndicator(uiView: self.view)
       if let addMedsViewController = WeeklyPlantSB.instantiateViewController(withIdentifier: "AddMedsViewController") as? AddMedsViewController {
         self.navigationController?.pushViewController(addMedsViewController, animated: true)
      }
    }
  }
  
  @IBAction func continueButtonAction(_ sender: Any) {
    yourWeelyPlanOnBoard()
  }
  
  func setUpButtonColour() {
    continueButtonOutlet.backgroundColor = AnthemColor.textBorderColor
  }
  
  func yourWeelyPlanOnBoard() {
    LocalStorageManager.setEditWeeklyPlanOnBoarding(status: true)
      if trackerMedsRadioButtonOutlet.currentImage == UIImage(named: viewModel.radioButtonTickMarkImage)?.withTintColor(AnthemColor.completedStatusColor) {
          LocalStorageManager.setTrackYourMeds(status: true)

      }  else {
          LocalStorageManager.setTrackYourMeds(status: false)
      }
      if stepsRadioButtonOutlet.currentImage == UIImage(named: viewModel.radioButtonTickMarkImage)?.withTintColor(AnthemColor.completedStatusColor) {
          LocalStorageManager.setTrackYourSteps(status: true)

      } else {
          LocalStorageManager.setTrackYourSteps(status: false)
      }
    self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    let vc = MainSB.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  @IBAction func goToHealthSettingAction(_ sender: Any) {
    if stepsRadioButtonOutlet.tag == viewModel.sharingNotDeterminedStepsTag {
      addHealthKitPermissionAlertView()
    } else {
      UIApplication.shared.open(URL(string: viewModel.healthAccessURL)!)
    }
  }
  
  @IBAction func changeCheckInTimeAction(_ sender: Any) {

    if let addReminderViewController = firstTimeSetupSB.instantiateViewController(withIdentifier: "DailyCheckinInitialViewController") as? DailyCheckinInitialViewController {
      self.navigationController?.pushViewController(addReminderViewController, animated: true)
    }
  }

}
