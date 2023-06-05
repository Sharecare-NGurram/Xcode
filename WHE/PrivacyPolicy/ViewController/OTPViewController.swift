//
//  OTPViewController.swift
//  WHE
//
//  Created by Rajesh Gaddam on 10/03/23.
//

import UIKit

class OTPViewController: UIViewController {
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var confirmLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var firstDigitTxtField: UITextField!
    @IBOutlet weak var secondDigitTxtField: UITextField!
    @IBOutlet weak var thirdDigitTxtField: UITextField!
    @IBOutlet weak var fourthDigitTxtField: UITextField!
    @IBOutlet weak var fifthDigitTxtField: UITextField!
    @IBOutlet weak var sixthDigitTxtField: UITextField!
    @IBOutlet weak var submitBtnTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var submitBtnBottomConstraint: NSLayoutConstraint!
    var pingDeviceId = ""
    var pingRiskId = ""
    var pingUserId = ""
    var token = ""
    var emailAddressText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubmitGrayButton()
        setupSelectors()
    }
    
    func setupSelectors() {
        confirmLbl.attributedText = confirmLbl.updateLineHeightMultipleLabel(with: confirmLbl.text ?? "", lineHeight: 1.4)
        confirmLbl.textAlignment = .center
        firstDigitTxtField.becomeFirstResponder()
        firstDigitTxtField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        secondDigitTxtField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        thirdDigitTxtField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        fourthDigitTxtField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        fifthDigitTxtField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        sixthDigitTxtField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        firstDigitTxtField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        secondDigitTxtField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        thirdDigitTxtField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        fourthDigitTxtField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        fifthDigitTxtField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        sixthDigitTxtField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    
    func setupSubmitButton(){
        if firstDigitTxtField.text?.count == 1 && secondDigitTxtField.text?.count == 1 && thirdDigitTxtField.text?.count == 1 && fourthDigitTxtField.text?.count == 1 && fifthDigitTxtField.text?.count == 1 && sixthDigitTxtField.text?.count == 1 {
            submitBtn.setTitleColor(AnthemColor.submitBtnWhiteColor, for: .normal)
            submitBtn.backgroundColor = AnthemColor.textBorderColor
            submitBtn.titleLabel?.font = UIFont.semiBold(ofSize: 16)
            submitBtn.isEnabled = true
        }
    }
    
    func setupSubmitGrayButton(){
        submitBtn.isEnabled = true
        submitBtn.setTitleColor(AnthemColor.submitBtnGrayColor, for: .normal)
        submitBtn.backgroundColor = AnthemColor.submitBtnBGGrayColor
        submitBtn.titleLabel?.font = UIFont.semiBold(ofSize: 16)
        
    }
    
    @IBAction func onClickResendCode(_ sender: Any) {
       
        resendCodeForGetEmail()
      
    }
    func setupResendTimer()
    {
        resendBtn.isEnabled = true
        resendBtn.setTitleColor(AnthemColor.resendGrayColor, for: .normal)
        self.resendBtn.setTitle("Code Resent", for: .normal)
        resendBtn.titleLabel?.font = UIFont.semiBold(ofSize: 16)
        DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) { // Change `2.0` to the desired number of seconds.
           // Code you want to be delayed
            self.resendBtn.isEnabled = true
            self.resendBtn.setTitle("Resend Code", for: .normal)
            self.resendBtn.setTitleColor(AnthemColor.textBorderColor, for: .normal)
            self.resendBtn.titleLabel?.font = UIFont.semiBold(ofSize: 16)
       
        }
    }
    
    func resendCodeForGetEmail() {
        resendBtn.isEnabled = false
        ApolloClientManager.shared.validateEmail(emailAddress : emailAddressText){
            [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                debugPrint(response)
                self.setupResendTimer()
                self.pingRiskId = response.pingRiskId ?? ""
                self.pingDeviceId = response.pingDeviceId ?? ""
                self.token = response.token ?? ""
                self.pingUserId = response.pingUserId ?? ""
            case .failure(let error):
                debugPrint(error)
                self.resendBtn.isEnabled = true
                self.showErrorAlertWIthBlurEffect {
                    // retry handler
                    self.resendCodeForGetEmail()
                }
            }
        }
    }
    
    func handleUpdateMailResponse(otp :String){
        updateEmailType(otp: otp, completion:{ isSuccess in
            if isSuccess {
                self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                let vc = MainSB.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                self.navigationController?.pushViewController(vc, animated: true)
             // need to handle based on response
            } else {
                // as of now it is failed so i have added this code
                self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                let vc = MainSB.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                self.navigationController?.pushViewController(vc, animated: true)
                //update email Mutation getting failed so commented this code
//                self.showErrorAlertWIthBlurEffect {
//                    // retry handler
//                   // self.handleUpdateMailResponse(otp: otp)
//                }
            }
        })
    }
   
    func updateEmailType(otp : String, completion: @escaping (Bool) -> Void){
         ApolloClientManager.shared.updateEmail(otp: otp, token: token, pingDeviceId: pingDeviceId, pingUserId: pingUserId, pingRiskId: pingRiskId){
                     [weak self] result in
                     guard let self = self else { return }
                     switch result {
                     case .success(let response):
                         print(response)
                         debugPrint(response)
                         completion(true)
                     case .failure(let error):
                         debugPrint("Get Consent url fetch error: \(error)")
                         completion(false)
                     }
                 }
     }
    
    @IBAction func onClickBack(_ sender: Any) {
      self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func onClickSubmitBtn(_ sender: Any) {
        let otpFinalString  = "\(firstDigitTxtField?.text ?? "")\(secondDigitTxtField?.text ?? "")\(thirdDigitTxtField?.text ?? "")\(fourthDigitTxtField?.text ?? "")\(fifthDigitTxtField?.text ?? "")\(sixthDigitTxtField?.text ?? "")"
        print(otpFinalString)
        self.handleUpdateMailResponse(otp : otpFinalString)
    }
    
    @objc func textFieldDidChange(textField: UITextField){
            let text = textField.text
            if  text?.count == 1 {
                switch textField{
                case firstDigitTxtField:
                    secondDigitTxtField.becomeFirstResponder()
                case secondDigitTxtField:
                    thirdDigitTxtField.becomeFirstResponder()
                case thirdDigitTxtField:
                    fourthDigitTxtField.becomeFirstResponder()
                case fourthDigitTxtField:
                    fifthDigitTxtField.becomeFirstResponder()
                case fifthDigitTxtField:
                    sixthDigitTxtField.becomeFirstResponder()
                case sixthDigitTxtField:
                    sixthDigitTxtField.becomeFirstResponder()
                default:
                    break
                }
                setupSubmitButton()
            }
            if  text?.count == 0 {
                switch textField{
                case firstDigitTxtField:
                    firstDigitTxtField.becomeFirstResponder()
                case secondDigitTxtField:
                    firstDigitTxtField.becomeFirstResponder()
                case thirdDigitTxtField:
                    secondDigitTxtField.becomeFirstResponder()
                case fourthDigitTxtField:
                    thirdDigitTxtField.becomeFirstResponder()
                case fifthDigitTxtField:
                    fourthDigitTxtField.becomeFirstResponder()
                case sixthDigitTxtField:
                    fifthDigitTxtField.becomeFirstResponder()
                default:
                    break
                }
                setupSubmitGrayButton()
            }
            else{

            }
        }
    
    @objc func doneButtonClicked(_ sender: Any) {
      //  keyBoardVisibeHideConstrains(hide: true)
            //your code when clicked on done
    }
    
    func keyBoardVisibeHideConstrains(visble: Bool = false, hide: Bool = false) {
        submitBtnTopConstraint.isActive = visble
        submitBtnBottomConstraint.isActive = hide
    }
}
extension  OTPViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField{
        case firstDigitTxtField:
            firstDigitTxtField.textColor = AnthemColor.textBorderColor
            firstDigitTxtField.layer.borderWidth = 2.0
            firstDigitTxtField.layer.masksToBounds = true
            firstDigitTxtField.layer.cornerRadius = 10.0
            firstDigitTxtField.layer.borderColor = AnthemColor.textBorderColor.cgColor
        case secondDigitTxtField:
            secondDigitTxtField.textColor = AnthemColor.textBorderColor
            secondDigitTxtField.layer.borderWidth = 2.0
            secondDigitTxtField.layer.masksToBounds = true
            secondDigitTxtField.layer.cornerRadius = 10.0
            secondDigitTxtField.layer.borderColor = AnthemColor.textBorderColor.cgColor
        case thirdDigitTxtField:
            thirdDigitTxtField.textColor = AnthemColor.textBorderColor
            thirdDigitTxtField.layer.borderWidth = 2.0
            thirdDigitTxtField.layer.masksToBounds = true
            thirdDigitTxtField.layer.cornerRadius = 10.0
            thirdDigitTxtField.layer.borderColor = AnthemColor.textBorderColor.cgColor
        case fourthDigitTxtField:
            fourthDigitTxtField.textColor = AnthemColor.textBorderColor
            fourthDigitTxtField.layer.borderWidth = 2.0
            fourthDigitTxtField.layer.masksToBounds = true
            fourthDigitTxtField.layer.cornerRadius = 10.0
            fourthDigitTxtField.layer.borderColor = AnthemColor.textBorderColor.cgColor
        case fifthDigitTxtField:
            fifthDigitTxtField.textColor = AnthemColor.textBorderColor
            fifthDigitTxtField.layer.borderWidth = 2.0
            fifthDigitTxtField.layer.masksToBounds = true
            fifthDigitTxtField.layer.cornerRadius = 10.0
            fifthDigitTxtField.layer.borderColor = AnthemColor.textBorderColor.cgColor
        case sixthDigitTxtField:
            sixthDigitTxtField.textColor = AnthemColor.textBorderColor
            sixthDigitTxtField.layer.borderWidth = 2.0
            sixthDigitTxtField.layer.masksToBounds = true
            sixthDigitTxtField.layer.cornerRadius = 10.0
            sixthDigitTxtField.layer.borderColor = AnthemColor.textBorderColor.cgColor
        default:
            break
        }
        keyBoardVisibeHideConstrains(visble: true)
        setupSubmitButton()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField{
        case firstDigitTxtField:
            firstDigitTxtField.textColor = AnthemColor.darkGray
            firstDigitTxtField.layer.borderWidth = 0.3
            firstDigitTxtField.layer.masksToBounds = true
            firstDigitTxtField.layer.cornerRadius = 10.0
            firstDigitTxtField.layer.borderColor = AnthemColor.lightGray.cgColor
        case secondDigitTxtField:
            secondDigitTxtField.textColor = AnthemColor.darkGray
            secondDigitTxtField.layer.borderWidth = 0.3
            secondDigitTxtField.layer.masksToBounds = true
            secondDigitTxtField.layer.cornerRadius = 10.0
            secondDigitTxtField.layer.borderColor = AnthemColor.lightGray.cgColor
        case thirdDigitTxtField:
            thirdDigitTxtField.textColor = AnthemColor.darkGray
            thirdDigitTxtField.layer.borderWidth = 0.3
            thirdDigitTxtField.layer.masksToBounds = true
            thirdDigitTxtField.layer.cornerRadius = 10.0
            thirdDigitTxtField.layer.borderColor = AnthemColor.lightGray.cgColor
        case fourthDigitTxtField:
            fourthDigitTxtField.textColor = AnthemColor.darkGray
            fourthDigitTxtField.layer.borderWidth = 0.3
            fourthDigitTxtField.layer.masksToBounds = true
            fourthDigitTxtField.layer.cornerRadius = 10.0
            fourthDigitTxtField.layer.borderColor = AnthemColor.lightGray.cgColor
        case fifthDigitTxtField:
            fifthDigitTxtField.textColor = AnthemColor.darkGray
            fifthDigitTxtField.layer.borderWidth = 0.3
            fifthDigitTxtField.layer.masksToBounds = true
            fifthDigitTxtField.layer.cornerRadius = 10.0
            fifthDigitTxtField.layer.borderColor = AnthemColor.lightGray.cgColor
        case sixthDigitTxtField:
            sixthDigitTxtField.textColor = AnthemColor.darkGray
            sixthDigitTxtField.layer.borderWidth = 0.3
            sixthDigitTxtField.layer.masksToBounds = true
            sixthDigitTxtField.layer.cornerRadius = 10.0
            sixthDigitTxtField.layer.borderColor = AnthemColor.lightGray.cgColor
            
         
        default:
            break
        }
        setupSubmitButton()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                    let allowedCharacters = "1234567890"
                    let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
                    let typedCharacterSet = CharacterSet(charactersIn: string)
                    let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
                    return alphabet
      }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keyBoardVisibeHideConstrains(hide: true)
        return true
    }
  
}

