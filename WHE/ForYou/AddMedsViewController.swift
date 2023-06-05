//
//  AddMedsViewController.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 20/01/23.
//

import UIKit



class AddMedsViewController: UIViewController {
  weak var delegate: NavigationGetMedsDataProtocal?
  weak var medDetailDelegate: AddMedsDetailProtocal?
  
  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var retryMainView: UIView!
  @IBOutlet weak var reTryButtonButtonOutlet: UIButton!
  @IBOutlet weak var noMedsDescriptionLabel: UILabel!
  @IBOutlet weak var noMedsHeaderLabel: UILabel!
  @IBOutlet weak var noMedsIcon: UIImageView!
  @IBOutlet weak var listOfMedsDescrptionTitle: UILabel!
  @IBOutlet weak var listOfMedsHeaderTitle: UILabel!
  @IBOutlet weak var addMedsMainView: UIView!
  @IBOutlet weak var addMedsButtonOutlet: UIButton!
  @IBOutlet weak var createMedsTableview: UITableView!
  @IBOutlet weak var topView: NSLayoutConstraint!
  @IBOutlet weak var bottomButton: NSLayoutConstraint!
  @IBOutlet weak var medsTableviewHeightConstrain: NSLayoutConstraint!
  var selectedMedicineArray : [MedicinesViewModel] = []
  var medicineDataModel = MedicineDataManager()
  var fromMedsScreen: Bool = false
  var multipleValues = 0
    
    override func viewDidLoad() {
    super.viewDidLoad()
    tableViewRegisterNib()
    applyCornerRadius()
    applyShadow()
    setButtonTitle()
    updatetheMedicinesInfo()
    addMulityLineLabel()
    noMedsViewSetUp()
   }
  
  override func viewDidLayoutSubviews() {
    medsTableviewHeightConstrain.constant = createMedsTableview.medsContentSizeHeight
    if medicineDataModel.medicineArray.count >= 8 {
      topView.constant = 20
      bottomButton.constant = 20
    } else {
      let iphone = UIScreen.main.bounds.height >= 900  ? 300 : 270
      let padding = UIScreen.main.bounds.height >= 900  ? 35 : 40
      topView.constant = CGFloat((iphone - (padding*medicineDataModel.medicineArray.count)))
      bottomButton.constant = CGFloat((iphone - (padding*medicineDataModel.medicineArray.count)))
    }
  }
  
  func addMulityLineLabel() {
    listOfMedsHeaderTitle.attributedText = listOfMedsHeaderTitle.updateLineHeightMultipleLabel(with: listOfMedsHeaderTitle.text ?? "", lineHeight: 1.05)
    listOfMedsHeaderTitle.font = UIFont.mediumBold(ofSize: 20)
    listOfMedsDescrptionTitle.attributedText = listOfMedsDescrptionTitle.updateLineHeightMultipleLabel(with: listOfMedsDescrptionTitle.text ?? "", lineHeight: 1.4)
    listOfMedsDescrptionTitle.font = UIFont.mediumBold(ofSize: 15)
    listOfMedsHeaderTitle.sizeToFit()
    listOfMedsHeaderTitle.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func applyCornerRadius() {
    addMedsButtonOutlet.layer.cornerRadius = 10
    addMedsMainView.layer.cornerRadius = 10
  }
  
  func applyShadow() {
    addMedsMainView.layer.masksToBounds = false
    addMedsMainView.layer.shadowColor = AnthemColor.addMedicationShadowColour
    addMedsMainView.layer.shadowOpacity = 1
    addMedsMainView.layer.shadowOffset = CGSize(width: 0, height: 2)
    addMedsMainView.layer.shadowRadius = 1
    addMedsMainView.layer.rasterizationScale = 1
  }
  
  func noMedsViewSetUp() {
    headerView.backgroundColor = UIColor.white
    self.view.backgroundColor = UIColor.white
    noMedsHeaderLabel.attributedText = noMedsHeaderLabel.updateLineHeightMultipleLabel(with: noMedsHeaderLabel.text  ?? "", lineHeight: 1.05)
    noMedsDescriptionLabel.attributedText = noMedsDescriptionLabel.updateLineHeightMultipleLabel(with: noMedsDescriptionLabel.text  ?? "", lineHeight: 1.4)
    noMedsIcon.image = UIImage(named: medicineDataModel.noMedsIconImg)?.withTintColor(AnthemColor.buttonDisableColor)
    noMedsHeaderLabel.textAlignment = .center
    noMedsDescriptionLabel.textAlignment = .center
    reTryButtonButtonOutlet.setTitle("Try Again", for: .normal)
    reTryButtonButtonOutlet.setTitleColor(AnthemColor.colonLabelColor, for: .normal)
    reTryButtonButtonOutlet.backgroundColor = AnthemColor.textBorderColor.withAlphaComponent(0.06)
   }
  
  @IBAction func reTryButtonAction(_ sender: Any) {
    switch multipleValues {
    case 0:
      ActivityIndicator.showActivityIndicator(uiView: self.view)
      DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
        ActivityIndicator.hideActivityIndicator(uiView: self.view)
        self.noMedsHeaderLabel.text = self.medicineDataModel.errorHeaderText
        self.noMedsDescriptionLabel.text = self.medicineDataModel.errorDesciptionText
        self.noMedsViewSetUp()
        self.noMedsIcon.image = UIImage(named: self.medicineDataModel.warningImg)?.withTintColor(AnthemColor.buttonDisableColor)
        self.multipleValues = 1
      }
      break
    default:
      ActivityIndicator.showActivityIndicator(uiView: self.view)
      DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
        ActivityIndicator.hideActivityIndicator(uiView: self.view)
        self.multipleValues = 0
        self.retryMainView.isHidden = true
        self.headerView.backgroundColor = AnthemColor.focusAreaColor
        self.view.backgroundColor = AnthemColor.focusAreaColor
      }
    }
  }
  
  func tableViewRegisterNib() {
    createMedsTableview.register(UINib(nibName: "MedsTableViewCell", bundle: nil), forCellReuseIdentifier: "MedsTableViewCell")
  }
  
  func setButtonTitle() {
    addMedsButtonOutlet.setTitle(fromMedsScreen ? "Select at least one": "I'm Takng None of Those", for: .normal)
    addMedsButtonOutlet.backgroundColor = fromMedsScreen ? AnthemColor.colorFromHex("#D7D7DB") : AnthemColor.colorFromHex("#794CFF")
  }
  
  @IBAction func dismissAction(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
  }
  
        @IBAction func addMedsAction(_ sender: Any) {
          if addMedsButtonOutlet.backgroundColor == AnthemColor.colorFromHex("#D7D7DB") {
            return
          }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: false)
            }
          LocalStorageManager.setMedicineSaved(status: true)
          ForYouViewController.medCount = selectedMedicineArray.count
          ForYouViewController.fromForYouScreen = fromMedsScreen ?  false : true
          delegate?.checkMedsDataSendBack(count: selectedMedicineArray.count)
          updateSelectedMedicinesInfo()
          if selectedMedicineArray.isEmpty {
              medDetailDelegate?.selected(info: selectedMedicineArray.count, title: "", moreThanOne: selectedMedicineArray.count >= 2)
          } else {
              medDetailDelegate?.selected(info: selectedMedicineArray.count, title: selectedMedicineArray.last!.title, moreThanOne: selectedMedicineArray.count >= 2)
          }
        }
  
  func updateSelectedMedicinesInfo() -> () {
     MedicineDataManager.shared.updateselectedMedInformation(add: true, updateMedInfo: selectedMedicineArray)
  }
  
  func updatetheMedicinesInfo() -> () {
    if medicineDataModel.medicineArray.isEmpty  {
      medicineDataModel.medicineArray = MedicineDataManager.shared.getMedInfo() ?? []
    }
  }
    
    func showErrorScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let loaderErrorViewController = storyboard.instantiateViewController(withIdentifier: "LoaderErrorBaseViewController") as? LoaderErrorBaseViewController {
            self.navigationController?.pushViewController(loaderErrorViewController, animated: true)
        }
    }
}

extension AddMedsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  medicineDataModel.medicineArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedsTableViewCell") as? MedsTableViewCell
      cell?.medsListTitle.text = medicineDataModel.medicineArray[indexPath.row].title
      cell?.medsBGView.backgroundColor = AnthemColor.medicationViewBGColor
      cell?.medsBGView.layer.cornerRadius = 10
      cell?.medsBGView.layer.borderWidth = 2
      cell?.medsBGView.layer.borderColor = AnthemColor.medicationViewBoaderColor
      cell?.medsListTitle.attributedText = cell?.medsListTitle.updateLineHeightMultipleLabel(with: medicineDataModel.medicineArray[indexPath.row].title,lineHeight: 1.24)
      cell?.medsListTitle.lineBreakMode = .byTruncatingTail
      cell?.medsListTitle.numberOfLines = 3
      cell?.medsListTitle.textColor = AnthemColor.colonLabelColor
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellToDeSelect = tableView.cellForRow(at: indexPath) as! MedsTableViewCell
        if cellToDeSelect.medsBGView.backgroundColor ==  AnthemColor.medicationViewBGColor  {
          selectedMedicineArray.append(medicineDataModel.medicineArray[indexPath.row])
             cellToDeSelect.isItemSelected = true
        } else {
          selectedMedicineArray.removeAll(where: { $0 == medicineDataModel.medicineArray[indexPath.row]})
          cellToDeSelect.isItemSelected = false
        }
        reloadMedicationTitle()
    }
    
    func reloadMedicationTitle() {
        if selectedMedicineArray.isEmpty {
            setButtonTitle()
        } else if selectedMedicineArray.count > 1 {
          addMedsButtonOutlet.backgroundColor = AnthemColor.colorFromHex("#794CFF")
          addMedsButtonOutlet.setTitle(fromMedsScreen ? "Add \(selectedMedicineArray.count) Medications" : "I’m Taking \(selectedMedicineArray.count) Medications", for: .normal)
        } else {
          var computedString = ""
          let countMedsLenght = fromMedsScreen ? 26 : 18
          if selectedMedicineArray[0].title.count > countMedsLenght {
            computedString = selectedMedicineArray[0].title.prefix(countMedsLenght) + "..."
          }
          else{
            computedString = selectedMedicineArray[0].title
          }
          addMedsButtonOutlet.backgroundColor = AnthemColor.colorFromHex("#794CFF")
          addMedsButtonOutlet.setTitle(fromMedsScreen ? "Add \(computedString)" : "I’m Taking \(computedString) ", for: .normal)
          addMedsButtonOutlet.setNeedsLayout()
        }
    }
}
extension UITableView {
  var medsContentSizeHeight: CGFloat {
    var height = CGFloat(0)
    for section in 0..<numberOfSections {
      height = height + rectForHeader(inSection: section).height
      let rows = numberOfRows(inSection: section)
      for row in 0..<rows {
        height = height + rectForRow(at: IndexPath(row: row, section: section)).height
      }
    }
    return height
  }
}


