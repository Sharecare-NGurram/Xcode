//
//  MedicationDetailsViewController.swift
//  WHE
//
//  Created by Rajesh Gaddam on 30/01/23.
//

import UIKit

protocol MedsDetailProtocal : class {
  func userDeletedItem(info: String, medArray : [MedicinesViewModel])
}

class MedicationDetailsViewController: UIViewController {
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var prescribedDetailLbl: UILabel!
    @IBOutlet weak var medicationSubTitle: UILabel!
    @IBOutlet weak var medicationHeaderTitle: UILabel!
    @IBOutlet weak var conditionTxt: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var medicineDetailsView: UIView!
    @IBOutlet weak var addConditionView: UIView!
    @IBOutlet weak var addNotesView: UIView!
    weak var delegate: MedsDetailProtocal?
    @IBOutlet weak var deleteMedBtn: UIButton!
    @IBOutlet weak var alertBGView: UIView!
    @IBOutlet weak var viewOnMapsBtn: UIButton!
    var selectedIndex = 0
    var medicineArray : [MedicinesViewModel] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        medicineArray = MedicineDataManager.shared.selectedMedDetails() ?? []
        setupTxtFields()
        setupViewBorders()
        notesTextView.delegate = self
        medicineDetailsView.clipsToBounds = true
        medicineDetailsView.layer.cornerRadius = 20
        medicineDetailsView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.alertBGView.alpha = 0
        addressLbl.text = "Pharmacy Name on July 22, 2022 \n 3170 Abrams Drive \n Twinsburg, Ohio, 44087"
    }
    
    @IBAction func onClickDeleteMed(_ sender: Any) {
        self.alertBGView.alpha = 1
        showAlertWindow(title: " Remove Medication? ", message: "Are you sure you want to remove \(medicineArray[selectedIndex].title) from your medications?", titles: [ "Remove", "Cancel"]) { title in
            if title == "Remove" {
                self.removeSelectedItem()
            } else {
                self.alertBGView.alpha = 0
            }
        }
    }
    
    func removeSelectedItem() {
        let medicineName = medicineArray[selectedIndex].title
        medicineArray.remove(at: selectedIndex)
        updatetheMedicinesInfo()
        self.dismiss(animated: true)
        delegate?.userDeletedItem(info: medicineName,medArray: medicineArray)
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 35.0/255.0, green: 30.0/255.0, blue: 51.0/255.0, alpha: 0.6).cgColor
        let colorBottom = UIColor(red: 35.0/255.0, green: 30.0/255.0, blue: 51.0/255.0, alpha: 0.9).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.gradientView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func setupViewBorders()
    {
        self.addConditionView.layer.cornerRadius = 10.0
        self.addConditionView.layer.borderWidth = 1
        addConditionView.layer.borderColor = UIColor(red: 0.47, green: 0.30, blue: 1.00, alpha: 0.06).cgColor
        self.addNotesView.layer.cornerRadius = 10.0
        self.addNotesView.layer.borderWidth = 1
        addNotesView.layer.borderColor = UIColor(red: 0.47, green: 0.30, blue: 1.00, alpha: 0.06).cgColor
        deleteMedBtn.setTitleColor(UIColor(red: 196/255, green: 79/255, blue: 83/255, alpha: 1.0), for: .normal)
        deleteMedBtn.titleLabel?.font =  UIFont.mediumBold(ofSize: 16)
        viewOnMapsBtn.titleLabel?.font =  UIFont.mediumBold(ofSize: 16)
        
    }
    func setupTxtFields() {
        if medicineArray.count > 0  {
            if medicineArray[selectedIndex].notes.count > 0 {
                notesTextView.attributedText = NSAttributedString(string:medicineArray[selectedIndex].notes, attributes:[NSAttributedString.Key.foregroundColor: UIColor.init(red: 35/255, green: 30/255, blue: 51/255, alpha: 1),NSAttributedString.Key.font :UIFont.mediumBold(ofSize: 15)])
            }
            else {
                notesTextView.attributedText = NSAttributedString(string:"Add Notes", attributes:[NSAttributedString.Key.foregroundColor: UIColor.init(red: 110/255, green: 107/255, blue: 121/255, alpha: 1),NSAttributedString.Key.font :UIFont.mediumBold(ofSize: 15)])
            }
            if medicineArray[selectedIndex].condition.count > 0 {
                conditionTxt.text = medicineArray[selectedIndex].condition
                conditionTxt.font = UIFont.mediumBold(ofSize: 15)
                conditionTxt.textColor = UIColor.init(red: 35/255, green: 30/255, blue: 51/255, alpha: 1)
            }
            else {
                conditionTxt.attributedPlaceholder = NSAttributedString(string:"Add Condition", attributes:[NSAttributedString.Key.foregroundColor: UIColor.init(red: 110/255, green: 107/255, blue: 121/255, alpha: 1),NSAttributedString.Key.font :UIFont.mediumBold(ofSize: 15)])
            }
            medicationHeaderTitle.text = medicineArray[selectedIndex].title
            medicationSubTitle.text = medicineArray[selectedIndex].subTitle
            addressLbl.attributedText = addressLbl.updateLineHeightMultipleLabel(with: addressLbl.text ?? "")
            prescribedDetailLbl.text = medicineArray[selectedIndex].prescription
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func gettheMedicinesInfo() -> [MedicinesViewModel?] {
        return MedicineDataManager.shared.getMedInfo() ?? []
    }
    
    @IBAction func onClickClose(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    
    func updatetheMedicinesInfo() -> () {
        MedicineDataManager.shared.updateselectedMedInformation(updateMedInfo: medicineArray)
    }
}

extension MedicationDetailsViewController : UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView == notesTextView {
      textView.text = nil
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView ==  notesTextView {
      if textView.text == ""{
        textView.text = "Add Notes"
        medicineArray[selectedIndex].notes = ""
          notesTextView.attributedText = NSAttributedString(string:"Add Notes", attributes:[NSAttributedString.Key.foregroundColor: UIColor.init(red: 110/255, green: 107/255, blue: 121/255, alpha: 1),NSAttributedString.Key.font :UIFont.mediumBold(ofSize: 15)])
          updatetheMedicinesInfo()
      }
      else {
        medicineArray[selectedIndex].notes = notesTextView.text
        updatetheMedicinesInfo()
        setupTxtFields()
      }
    }
  }
}

extension MedicationDetailsViewController : UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField == conditionTxt{
      if textField.text != ""{
        medicineArray[selectedIndex].condition = conditionTxt.text ?? ""
        updatetheMedicinesInfo()
      }
        else
        {
            conditionTxt.attributedPlaceholder = NSAttributedString(string:"Add Condition", attributes:[NSAttributedString.Key.foregroundColor: UIColor.init(red: 110/255, green: 107/255, blue: 121/255, alpha: 1),NSAttributedString.Key.font :UIFont.mediumBold(ofSize: 15)])
            medicineArray[selectedIndex].condition =  ""
            updatetheMedicinesInfo()
        }
    }
  }
}
