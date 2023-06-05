//
//  ConfirmEmailAddressViewController.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 08/03/23.
//

import UIKit
import IQKeyboardManagerSwift

class ConfirmEmailAddressViewController: UIViewController {
  @IBOutlet weak var keyBoardVisible: NSLayoutConstraint!
  @IBOutlet weak var textfiledMainView: UIView!
  @IBOutlet weak var emailAddressHintLabel: UILabel!
  @IBOutlet weak var descritionLabel: UILabel!
  @IBOutlet weak var yourEmailHeaderLabel: UILabel!
  @IBOutlet weak var emailValidationButtonOutlet: UIButton!
  @IBOutlet weak var keyBoardHide: NSLayoutConstraint!
  @IBOutlet weak var emailAddress: UITextField!
  let viewModel = ConfirmEmailAddressViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    keyboardManagerSetup()
    labelsParagraphStyle()
    applyViewShadowOpacity()
    self.emailValidationButtonOutlet.isUserInteractionEnabled = false
    addTapGestureForView()
    textifieldDefultSelected()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.emailAddress.becomeFirstResponder()
  }
  
  func textifieldDefultSelected() {
    emailAddress.becomeFirstResponder()
  }
  
  // MARK: - Add TapGesture For View
  func addTapGestureForView() {
    let tapGesture = UITapGestureRecognizer(target: self, action: nil)
    self.view.isUserInteractionEnabled = true
    self.view.addGestureRecognizer(tapGesture)
  }
  
  // MARK: - Label ParagraphStyle
  func labelsParagraphStyle() {
    self.yourEmailHeaderLabel.attributedText  = yourEmailHeaderLabel.updateLineHeightMultipleLabel(with: yourEmailHeaderLabel.text ?? "", lineHeight: 1.04)
    self.descritionLabel.attributedText       = descritionLabel.updateLineHeightMultipleLabel(with: descritionLabel.text  ?? "", lineHeight: 1.32)
    self.emailAddressHintLabel.attributedText = emailAddressHintLabel.updateLineHeightMultipleLabel(with: emailAddressHintLabel.text ?? "", lineHeight: 1.4)
  }
  
  // MARK: - View Shadow Opacity Boader Etc...
  func applyViewShadowOpacity(withSelect: Bool = false) {
    textfiledMainView.layer.cornerRadius      = 10
    textfiledMainView.layer.backgroundColor   = AnthemColor.colorFromHex("#F9FAFB").cgColor
    textfiledMainView.layer.shadowOpacity     = 1
    textfiledMainView.layer.bounds            = textfiledMainView.bounds
    textfiledMainView.layer.position          = textfiledMainView.center
    textfiledMainView.tintColor               = AnthemColor.colorFromHex("#794CFF")
    textfiledMainView.layer.borderWidth       = withSelect ? 2.0 : 1.0
    textfiledMainView.layer.shadowRadius      = withSelect ? 6 : 0
    textfiledMainView.layer.shadowOffset      = CGSize(width: 0, height: withSelect ? 3 : 0)
    textfiledMainView.layer.borderColor       = withSelect ? AnthemColor.colorFromHex("#794CFF").cgColor : AnthemColor.colorFromHex("#231E33").withAlphaComponent(0.04).cgColor
    textfiledMainView.layer.shadowColor       = withSelect ? UIColor(red: 0.475, green: 0.298, blue: 1, alpha: 0.25).cgColor : UIColor.clear.cgColor
  }
  
  // MARK: - KeyBoard Defult Done Arrow Hide
  func keyboardManagerSetup() {
    IQKeyboardManager.shared.enable = true
    IQKeyboardManager.shared.enableAutoToolbar = false
    keyBoardNotificationCenterAddObserver()
  }
  
  // MARK: - Handle Keyboard Constrains
  func keyBoardVisibeHideConstrains(visble: Bool = false, hide: Bool = false) {
    keyBoardVisible.isActive   = visble
    keyBoardHide.isActive      = hide
  }
  
  // MARK: - KeyBoard Notification Observer
  func keyBoardNotificationCenterAddObserver() {
    NotificationCenter.default.addObserver(self, selector: #selector(self.updateView), name: UIApplication.didBecomeActiveNotification, object: nil)
  }
  
  // MARK: - DeInit KeyBoard Notification Observer 
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func updateView() {
    keyboardManagerSetup()
    applyViewShadowOpacity(withSelect: true)
    emailAddress.becomeFirstResponder()
    keyBoardVisibeHideConstrains(visble: true)
    
  }

    
    func validateEmailType(email: String) {
        ApolloClientManager.shared.validateEmail(emailAddress : email){
            [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                debugPrint(response)
                self.emailAddress.becomeFirstResponder()
                let vc = PrivacySB.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                vc.pingRiskId = response.pingRiskId ?? ""
                vc.pingDeviceId = response.pingDeviceId ?? ""
                vc.token = response.token ?? ""
                vc.pingUserId = response.pingUserId ?? ""
                vc.emailAddressText = email
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            case .failure(let error):
                debugPrint(error)
                self.showErrorAlertWIthBlurEffect {
                    // retry handler
                    self.handleConfirmMailSucess()
                }
            }
        }
        
        
    }
  
  // MARK: - Email Send Button Action
  @IBAction func emailValidationButtonAction(_ sender: Any) {
      handleConfirmMailSucess()
  }
    
    func handleConfirmMailSucess() {
        validateEmailType(email: emailAddress.text ?? "")
    }
  
  // MARK: - Close Button Action
  @IBAction func dismissButtonAction(_ sender: Any) {
    self.emailAddress.resignFirstResponder()
    self.dismiss(animated: true, completion: nil)
  }
  
  func buttonTextUpdate(text: String) {
    let values = viewModel.isValidEmail(text)
    if values == true {
      self.emailValidationButtonOutlet.backgroundColor = AnthemColor.colorFromHex("#794CFF")
      self.emailValidationButtonOutlet.setTitleColor(.white, for: .normal)
      self.emailValidationButtonOutlet.setTitle(viewModel.validEmailButtonTitle, for: .normal)
      self.emailValidationButtonOutlet.isUserInteractionEnabled = true
    } else {
      self.emailValidationButtonOutlet.backgroundColor = AnthemColor.colorFromHex("#D7D7DB")
      self.emailValidationButtonOutlet.setTitleColor(AnthemColor.colorFromHex("#6E6B79"), for: .normal)
      self.emailValidationButtonOutlet.setTitle(viewModel.emptyEmailButtonTitle, for: .normal)
      self.emailValidationButtonOutlet.isUserInteractionEnabled = false
    }
  }
}

// MARK: - UITextFieldDelegate
extension ConfirmEmailAddressViewController: UITextFieldDelegate {
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    keyBoardVisibeHideConstrains(visble: true)
    keyboardManagerSetup()
    applyViewShadowOpacity(withSelect: true)
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if emailValidationButtonOutlet.isUserInteractionEnabled {
      self.emailValidationButtonAction(self)
    }
    return true
  }
  
  func textFieldDidChangeSelection(_ textField: UITextField) {
    self.buttonTextUpdate(text: textField.text ?? "")
  }
}
