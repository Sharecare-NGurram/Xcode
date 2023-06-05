//
//  WelcomeViewController.swift
//  WHE
//
//  Created by Rajesh Gaddam on 21/02/23.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var anthemBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        anthemBtn.layer.cornerRadius = 10.0
        anthemBtn.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.barStyle = .default
    
    }
    
    @IBAction func onClickSettings(_ sender: Any) {
        if let configSettingViewController = MainSB.instantiateViewController(withIdentifier: "ConfigSettingViewController") as? ConfigSettingViewController {
          self.navigationController?.pushViewController(configSettingViewController, animated: true)
       }
    }
    
    @IBAction func SignInAnthemClicker(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : LoginApiViewController = storyboard.instantiateViewController(withIdentifier: "LoginApiViewController") as! LoginApiViewController
        self.navigationController?.pushViewController(vc, animated: true)
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
