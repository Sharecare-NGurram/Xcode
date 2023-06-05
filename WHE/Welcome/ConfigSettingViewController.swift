//
//  ConfigSettingViewController.swift
//  WHE
//
//  Created by Rajesh Gaddam on 14/04/23.
//

import UIKit

class ConfigSettingViewController: UIViewController {
    @IBOutlet weak var txtViewForURL: UITextView!
    @IBOutlet weak var envTitle: UITextField!
    var urlString = ""
    var environments: [AppEnvironment] = []
    var selectedEnvironment: AppEnvironment = .localhost
    @IBOutlet weak var configTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
  
    func setupView() {
        self.view.endEditing(true)
        setupEnvironments()
        setupTableView()
        configTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        configTable.isHidden = true
        envTitle.resignFirstResponder()
        txtViewForURL.resignFirstResponder()
    }
    
    func setupEnvironments() {
        environments = []
        let envVar = LocalStorageManager.fetchCheckEnvironment()
        if let current = AppEnvironment(rawValue: envVar) {
            selectedEnvironment = current
            envTitle.text = current.rawValue
            txtViewForURL.attributedText = NSAttributedString(string:current.endpoint(), attributes:[NSAttributedString.Key.foregroundColor: AnthemColor.configTxtColor,NSAttributedString.Key.font :UIFont.mediumBold(ofSize: 15)])

        } else  {
            let newEnvironment = AppEnvironment.localhost
            if ApolloClientManager.shared.loadClient(environment: newEnvironment, token: "") {
                selectedEnvironment = newEnvironment
                envTitle.text = newEnvironment.rawValue
                txtViewForURL.attributedText = NSAttributedString(string:newEnvironment.endpoint(), attributes:[NSAttributedString.Key.foregroundColor: AnthemColor.configTxtColor,NSAttributedString.Key.font :UIFont.mediumBold(ofSize: 15)])
            }
        }
        environments.append(selectedEnvironment)
        for environment in AppEnvironment.allCases.filter({ environment in
            if environment == selectedEnvironment {
                return false
            }
            return true
        }) {
            environments.append(environment)
        }

    }
    
    func setupTableView() {
        configTable.delegate = self
        configTable.dataSource = self
    }
    
    @IBAction func onClcikBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onClickSaveBtn(_ sender: Any) {
        if ApolloClientManager.shared.loadClient(environment: selectedEnvironment, token: "") {
            self.navigationController?.popViewController(animated: true)
        }
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
extension ConfigSettingViewController : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return environments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //AnthemColor
        cell.textLabel?.attributedText = NSAttributedString(string:environments[indexPath.row].rawValue, attributes:[NSAttributedString.Key.foregroundColor: AnthemColor.configTxtColor,NSAttributedString.Key.font :UIFont.mediumBold(ofSize: 15)])
        cell.selectionStyle = .none
        urlString = environments[indexPath.row].endpoint()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEnvironment = environments[indexPath.row]
        envTitle.text = environments[indexPath.row].rawValue
        txtViewForURL.text = environments[indexPath.row].endpoint()
        configTable.isHidden = true
    }
}

extension  ConfigSettingViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == envTitle {
            configTable.isHidden = false
        }
        return false
    }
}

extension ConfigSettingViewController : UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView == txtViewForURL {
      textView.text = nil
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView ==  txtViewForURL {
      if textView.text == ""{
        textView.text = "URL"
          txtViewForURL.attributedText = NSAttributedString(string:"URL", attributes:[NSAttributedString.Key.foregroundColor: AnthemColor.configTxtColor,NSAttributedString.Key.font :UIFont.mediumBold(ofSize: 15)])
      }
    }
  }
}
