//
//  HealthSettingsViewController.swift
//  WHE
//
//  Created by Rajesh Gaddam on 06/04/23.
//

import UIKit

class HealthSettingsViewController: UIViewController {
    @IBOutlet weak var healthDataLbl: UILabel!
    
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var descLbl: UILabel!
    let permissionsHealthKitViewModel = HealthKitPermissionsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup() {
        settingsBtn.addLeftPadding(CGFloat(Constants.settingsBtnPaddingValue))
        healthDataLbl.attributedText = self.healthDataLbl.updateLineHeightMultipleLabel(with: healthDataLbl.text ?? "" , lineHeight: Constants.healthTextConstant)
        healthDataLbl.textAlignment = .center
        descLbl.attributedText = self.descLbl.updateLineHeightMultipleLabel(with: descLbl.text ?? "" , lineHeight: Constants.healthDescriptionTextConstant)
        descLbl.textAlignment = .center
    }
    
    func notificationCenterAddObserverSettings() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateViewHealthSettings), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func updateViewHealthSettings() {
        checkHealthStatus()
    }
    
    
    func checkHealthStatus() {
        let status = permissionsHealthKitViewModel.healthKitAccess()
        switch status {
        case .sharingDenied:
            break
        case .sharingAuthorized:
            self.navigationController?.popViewController(animated: true)
            break
        default:
            break
        }
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickSettingsBtn(_ sender: Any) {
        notificationCenterAddObserverSettings()
        UIApplication.shared.open(URL(string: "App-prefs:Privacy&path=HEALTH")!)
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
extension UIButton {
    func addLeftPadding(_ padding: CGFloat) {
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: padding, bottom: 0.0, right: -padding)
        contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: padding)
    }
}
