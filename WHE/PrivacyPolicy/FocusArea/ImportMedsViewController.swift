//
//  ImportMedsViewController.swift
//  WHE
//
//  Created by Pratima Pundalik on 27/03/23.
//

import UIKit

protocol NavigationGetMedsDataProtocal : class {
    func checkMedsDataSendBack(count: Int)
}

class ImportMedsViewController: UIViewController, NavigationGetMedsDataProtocal {

    weak var delegate: NavigationMedsProtocal?
    @IBOutlet weak var prescriptionLabel: UILabel!
    @IBOutlet weak var dailyReminderLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var importMeds: UILabel!
    @IBOutlet weak var importMedsDescription: UILabel!
    @IBOutlet weak var importMedicine: UIButton!
    @IBOutlet weak var notRightNowButton: UIButton!
    @IBOutlet weak var byImportLabel: UILabel!
    
    private var importMedsViewModel = ImportMedsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notRightNowButton.setTitleColor(AnthemColor.textBorderColor, for: .normal)
        configureImportOptionsColor(textColor: AnthemColor.enabledDateTextColor)
        importMedsText()
        configureImportOptionsFont()
        configureMedsDescription()
        notRightNowButtonCall()
    }
  
    func notRightNowButtonCall() {
        notRightNowButton.addTarget(self, action: #selector(notRightNowButtonAction), for: .touchUpInside)
    }
  
    @objc func notRightNowButtonAction() {
        LocalStorageManager.setTrackMedicinesNotRightNow(status: true)
        self.navigationController?.popViewController(animated: true)
    }
  
    @IBAction func closeAction(_ sender: Any) {
        LocalStorageManager.setTrackMedicinesNotRightNow(status: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkMedsDataSendBack(count: Int){
        delegate?.checkMedsadded(count: count)
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    func configureMedsDescription(){
        importMedsDescription.attributedText = self.importMedsDescription.updateLineHeightMultipleLabel(with: importMedsDescription.text ?? "" , lineHeight: 1.32)
        importMedsDescription.textAlignment = .center
    }
    func configureImportOptionsFont(){
        importMeds.font = UIFont.semiBold(ofSize: 24)
        byImportLabel.font = UIFont.semiBold(ofSize: 16)
        importMedsDescription.font = UIFont.mediumBold(ofSize: 16)
        dailyReminderLabel.font = UIFont.mediumBold(ofSize: 16)
        notesLabel.font = UIFont.mediumBold(ofSize: 16)
        prescriptionLabel.font = UIFont.mediumBold(ofSize: 16)
    }
    
    @IBAction func onClickImportMeds(_ sender: Any) {
        ActivityIndicator.showActivityIndicator(uiView: self.view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            ActivityIndicator.hideActivityIndicator(uiView: self.view)
             if let addMedsViewController = WeeklyPlantSB.instantiateViewController(withIdentifier: "AddMedsViewController") as? AddMedsViewController {
                addMedsViewController.delegate = self
              self.navigationController?.pushViewController(addMedsViewController, animated: true)
                      }
        }

    }
    
    func configureImportOptionsColor(textColor: UIColor) {
        importMedicine.layer.cornerRadius = 10
        byImportLabel.textColor = textColor
        importMeds.textColor = textColor
        importMedsDescription.textColor = textColor
        dailyReminderLabel.textColor = textColor
        notesLabel.textColor = textColor
        prescriptionLabel.textColor = textColor
        importMedicine.backgroundColor = AnthemColor.textBorderColor
    }
    
    func importMedsText(){
        importMeds.text = importMedsViewModel.importMeds
        importMedsDescription.text = importMedsViewModel.importMedsDescription
        byImportLabel.text = importMedsViewModel.byImport
        showCheckMarkWith(medicationText: importMedsViewModel.dailyReminders, medicationLabel: dailyReminderLabel)
        showCheckMarkWith(medicationText: importMedsViewModel.prescription, medicationLabel: prescriptionLabel)
        showCheckMarkWith(medicationText: importMedsViewModel.medsNotes, medicationLabel: notesLabel)
    }
    
    func showCheckMarkWith(medicationText:String, medicationLabel:UILabel){
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named:"checkMark")
        let imageOffsetY: CGFloat = -5.0
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let textAfterIcon = NSAttributedString(string: medicationText)
        completeText.append(textAfterIcon)
        medicationLabel.textAlignment = .center
        medicationLabel.attributedText = completeText
    }
    
}

