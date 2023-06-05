//
//  PrivacyPolicyViewController.swift
//  WHE
//
//  Created by Rajesh Gaddam on 03/03/23.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {
    var viewModel = PrivacyViewModel()
    @IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var privacyHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollViewOutlet: UIScrollView!
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        showConsentScreens(htmlString: ConsentType.earlyAccess.rawValue)
        self.webView.scrollView.isScrollEnabled = false
        self.webView.navigationDelegate = self
        privacyHeightConstraint.constant = -50.0
        // Do any additional setup after loading the view.
    }
    
    func showPrivacyConsentScreen() {
        scrollViewOutlet.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        privacyHeightConstraint.constant = viewModel.privacyHeight
        agreeBtn.setTitle(viewModel.privacyTitle, for: .normal)
        self.showConsentScreens(htmlString: ConsentType.privacy.rawValue)
    }
    
    func handleSaveEarlyAccess() {
        savingConsents(type: ConsentType.earlyAccess, completion: { isSuccess in
            if isSuccess {
                self.showPrivacyConsentScreen()
            } else {
                self.showErrorAlertWIthBlurEffect {
                    // retry handler
                    self.savingConsents(type: ConsentType.earlyAccess) { isSuccess in
                        if isSuccess {
                            self.showPrivacyConsentScreen()
                        }
                    }
                }
            }
        })
    }
    
    func handleSavePrivacyAccess() {
        savingConsents(type: ConsentType.privacy, completion: { isSuccess in
            if isSuccess {
                self.showMainTabBarController()
            } else {
                self.showErrorAlertWIthBlurEffect {
                    // retry handler
                    self.handleSavePrivacyAccess()
                }
            }
        })
    }
    
    func showMainTabBarController() {
        let vc = MainSB.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
                       
    @IBAction func onClickAction(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal) {
            if buttonTitle == viewModel.consentTitle {
                self.handleSaveEarlyAccess()
            } else {
                self.handleSavePrivacyAccess()
            }
        }
    }
    
    func showConsentScreens(htmlString : String) {
        if let needConsentCount = ApolloClientManager.shared.needConsentArray?.count,
           needConsentCount > 0 {
            if htmlString == ConsentType.privacy.rawValue {
                let privacyString = viewModel.loadHTMLStringForPrivacyPolicy()
                webView.loadHTMLString(privacyString, baseURL: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) {  self.webView.scrollView.setContentOffset(CGPoint.zero, animated: true)
                    self.webView.scrollView.scrollsToTop = true
                }
            } else{
                let earlyAccessString = viewModel.loadHTMLForEarlyAccess()
                webView.loadHTMLString(earlyAccessString, baseURL: nil)
            }
        } else {
            let vc = MainSB.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func savingConsents(type: ConsentType, completion: @escaping (Bool) -> Void) {
        ApolloClientManager.shared.saveAgreementForConsents(type: type){
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
}

extension PrivacyPolicyViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.webViewHeightConstraint.constant = webView.scrollView.contentSize.height
        }
       
    }
}
