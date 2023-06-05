//
//  FocusAreaViewController.swift
//  WHE
//
//  Created by Rajesh Gaddam on 23/03/23.
//

import UIKit

protocol NavigationMedsProtocal : class {
    func checkMedsadded(count: Int)
}

class FocusAreaViewController: UIViewController, NavigationMedsProtocal {
    weak var delegate: NavigationMedsProtocal?
  let permissionsHealthKitViewModel = HealthKitPermissionsViewModel()
  let readStepsViewModel = HealthKitReadStepsInfoViewModel()
    var viewModel = FocusAreaViewModel()
    var isSpinnerHidden = true
    var sharingAuthorizationAllow = false
    @IBOutlet weak var spinnerImageView: UIImageView!
    @IBOutlet weak var focusAreaTable: UITableView!
    @IBOutlet weak var healthLbl: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelUpdateparagraphStyle()
        notificationCenterAddObserverFocusArea()
        if LocalStorageManager.fetchMedicineSaved() {
            enableContinueButton(true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        focusAreaTable.reloadData()
    }
    
    func enableContinueButton(_ : Bool){
        continueBtn.setTitle(viewModel.continueButtonTitle, for: .normal)
        continueBtn.backgroundColor = AnthemColor.textBorderColor
        continueBtn.setTitleColor(AnthemColor.submitBtnWhiteColor, for: .normal)
    }
    
    func checkMedsadded(count: Int){
        focusAreaTable.reloadData()
        let toastMessage = "Imported \(count ?? 0) medications"
        self.showToast(message:toastMessage,fontSize: 16)
    }
  
  func notificationCenterAddObserverFocusArea() {
    NotificationCenter.default.addObserver(self, selector: #selector(self.updateViewFocusArea), name: UIApplication.didBecomeActiveNotification, object: nil)
  }
  
  @objc func updateViewFocusArea() {
    self.focusAreaTable.reloadData()
   }
  
  func setLabelUpdateparagraphStyle() {
    healthLbl.attributedText = healthLbl.updateLineHeightMultipleLabel(with: healthLbl.text ?? "", lineHeight: 1.32)
    healthLbl.textAlignment = .left
    focusAreaTableViewRegisterNib()
    showLoader(isHidden: true)
  }
    
    func focusAreaTableViewRegisterNib() {
        focusAreaTable.register(UINib(nibName: "FocusAreaTableViewCell", bundle: nil), forCellReuseIdentifier: "FocusAreaTableViewCell")
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
  
    
    @IBAction func continueButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "FirstTimeSetup", bundle: Bundle.main)
        if let dailyCheckinInitialViewController = storyboard.instantiateViewController(withIdentifier: "DailyCheckinInitialViewController") as? DailyCheckinInitialViewController {
            //  addMedsViewController.delegate = self
            self.navigationController?.pushViewController(dailyCheckinInitialViewController, animated: true)
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
              self.focusAreaTable.reloadData()
            }
          })
        }
        self.style = .default
        self.setNeedsStatusBarAppearanceUpdate()
      }
      break
    case .sharingDenied:
        healthSettingView()
      self.focusAreaTable.reloadData()
      break
    case .sharingAuthorized:
      break
    default:
      break
    }
  }
}

extension FocusAreaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getFocusAreaArray.count
    }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FocusAreaTableViewCell", for: indexPath) as! FocusAreaTableViewCell
    cell.descriptionLbl.attributedText = cell.descriptionLbl.updateLineHeightMultipleLabel(with: viewModel.getFocusAreaArray[indexPath.row], lineHeight: 1.4)
    cell.activeImg.image = UIImage(named: viewModel.listImages[indexPath.row])
    cell.title.text = viewModel.getDescriptionAreaArray[indexPath.row]
      if indexPath.row == Constants.trackMedicinesTag {
          if LocalStorageManager.fetchMedicineSaved() {
              cell.setSharingTrackMeds = true
              enableContinueButton(true)
          }
      }
      else if indexPath.row == Constants.activeTag {
          let status = permissionsHealthKitViewModel.healthKitAccess()
          switch status {
          case .sharingDenied:
              cell.setSharingDeniedCell = true
              sharingAuthorizationAllow = false

          case .notDetermined:
              cell.setnotDeterminedCell = true
              sharingAuthorizationAllow = false
              break
          case .sharingAuthorized:
              cell.setSharingAuthorizationCell = true
              sharingAuthorizationAllow = true
              enableContinueButton(true)
              break
          default:
              break
          }
      }
      return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == Constants.trackMedicinesTag {
      trackMedsView()
    } else if indexPath.row == Constants.activeTag && !sharingAuthorizationAllow {
      addHealthKitPermissionAlertView()
    }
  }
    func healthSettingView() {
        if let healthSettingsViewController = PrivacySB.instantiateViewController(withIdentifier: "HealthSettingsViewController") as? HealthSettingsViewController {
          self.navigationController?.pushViewController(healthSettingsViewController, animated: true)
        }
    }
  
  func trackMedsView() {
    if let importMedsViewController = MainSB.instantiateViewController(withIdentifier: "ImportMedsViewController") as? ImportMedsViewController {
        importMedsViewController.delegate = self
      self.navigationController?.pushViewController(importMedsViewController, animated: true)
    }
  }
}
