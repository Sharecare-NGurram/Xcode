//
//  GetStartedHomeViewController.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 28/02/23.
//

import UIKit
import Apollo

class GetStartedHomeViewController: UIViewController {
  
  @IBOutlet weak var getStartedBtn: UIButton!
  @IBOutlet weak var descLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateMultiLineLabel()
        setupButton()
        self.navigationItem.setHidesBackButton(true, animated: true)
        getUserConsent()
    }
    
    func getUserConsent() {
        ApolloNetworkHelper.shared.getConsentDetails { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                print(response)
                
            case .failure(let error):
                debugPrint("getConsent url fetch error: \(error)")
            }
        }
    }
  
  func setupButton(){
    getStartedBtn.clipsToBounds = true
    getStartedBtn.layer.cornerRadius = 10.0
    getStartedBtn.backgroundColor = UIColor(hexString: "794CFF")
    
  }
  
  func updateMultiLineLabel(){
    descLbl.attributedText = self.descLbl.updateLineHeightMultipleLabel(with: descLbl.text ?? "", lineHeight: 1.4 )
    descLbl.font = UIFont(name: "ElevanceSans-Medium", size: 16)
  }
}
