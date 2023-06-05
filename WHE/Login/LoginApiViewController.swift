//
//  LoginApiViewController.swift
//  WHE
//
//  Created by Srikanth General on 16/02/23.
//

import Foundation
import UIKit
import WebKit

class LoginApiViewController: UIViewController {
    
    var webView: WKWebView?
    var url_base: String?
    var loginResponse: LoginResponseModel?
    
    func addWebView() {
        let configuration  = WKWebViewConfiguration()
        configuration.userContentController.add(self, name: "loginWebview")
        self.webView = WKWebView(frame: .zero, configuration: configuration)
        self.webView?.translatesAutoresizingMaskIntoConstraints = false
        self.webView?.allowsLinkPreview = true
        self.webView?.allowsBackForwardNavigationGestures = true
        self.webView?.navigationDelegate = self
        guard let webView = self.webView else {
            return
        }
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            webView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant : 65),
        ])
        self.view.setNeedsLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        newPrescrptionUserDataRemove()
        addWebView()
        ApolloClientManager.shared.fetchLoginDetails { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                // ,let newLoginUrl =  NSURL(string: loginUrl.replacingOccurrences(of: "3000", with: "8080")) as? URL
                self.loginResponse = response
                if let loginUrlString = response.login_url,
                   let newLoginUrl =  URL(string: loginUrlString){
                    debugPrint("Login URL - \(loginUrlString)")
                    self.webView?.load(NSURLRequest(url: newLoginUrl) as URLRequest)
                    self.url_base = response.url_base
                    return
                }
                debugPrint("Empty login url ....")
            case .failure(let error):
                debugPrint("login url fetch error: \(error)")
            }
        }
        
    }
    
    func newPrescrptionUserDataRemove() {
      LocalStorageManager.setMedsNewPrescription(status: false)
    }
    
    func moveToGetStartedScreen()  {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if LocalStorageManager.fetchLetsGetStarted() == true {
            let vc = PrivacySB.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard.instantiateViewController(withIdentifier: "LetsGetStartedViewController") as! LetsGetStartedViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func onClickClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func sucessfulLogin() {
        ApolloClientManager.shared.getConsentDetails { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.moveToGetStartedScreen()
                debugPrint(response)
                
            case .failure(let error):
                debugPrint("Get Consent url fetch error: \(error)")
            }
        }
    }
}

extension LoginApiViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        debugPrint("message: \(message)")
        if let messageBody:NSDictionary = message.body as? NSDictionary{
            debugPrint("messageBody: \(messageBody)")
        }
    }
}


extension LoginApiViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("page finished load")
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("didReceiveServerRedirectForProvisionalNavigation: \(navigation.debugDescription)")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlBase = url_base,
           let navUrl = navigationAction.request.url?.absoluteURL.absoluteString,
           navUrl.starts(with: urlBase) {
            if let accessTokenKey = loginResponse?.access_token,
               let queryParams = navigationAction.request.url?.queryParameters,
               let accessToken = queryParams[accessTokenKey] {
                let client = ApolloClientManager.shared
                client.accessToken = accessToken
                debugPrint("accessToken - \(accessToken)")
                if let refreshTokenKey = loginResponse?.refresh_token,
                   let refreshToken = queryParams[refreshTokenKey],
                   let expirationKey = loginResponse?.expiration_seconds,
                   let expirationValueStr = queryParams[expirationKey],
                   let expirationValue = Double(expirationValueStr) {
                    client.refreshToken = refreshToken
                    client.tokenExpirationSeconds = Double(expirationValue)
                    debugPrint("refreshToken - \(refreshToken), expiration_seconds - \(expirationValue)")
                }
            }
            self.sucessfulLogin()
        }

        if (navigationAction.navigationType == .linkActivated){
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}
