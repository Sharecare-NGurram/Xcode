//
//  MedsViewController.swift
//  WHE
//
//  Created by Venkateswarlu Samudrala on 19/01/23.
//

import UIKit
import NotificationCenter

protocol AddMedsDetailProtocal : class {
  func selected(info: Int, title: String, moreThanOne: Bool)
}

class MedsViewController: UIViewController {
  @IBOutlet weak var newPrescriptionDescrptionLabel: UILabel!
  @IBOutlet weak var newPrescriptionHeaderTitleLabel: UILabel!
  @IBOutlet weak var notFountPrescriptionConstrain: NSLayoutConstraint!
  @IBOutlet weak var newPrescriptionFoundConstrain: NSLayoutConstraint!
  @IBOutlet weak var prescriptionMainView: UIView!
  @IBOutlet weak var yourMedicationHeaderLable: UILabel!
  @IBOutlet weak var newPrescriptionTableview: UITableView!
  @IBOutlet weak var addPrescriptionButtonOutlet: UIButton!
  @IBOutlet weak var newPrescriptionTableviewHeightConstrain: NSLayoutConstraint!
  @IBOutlet weak var dontAddPrescriptionButtonOutlet: UIButton!
  @IBOutlet weak var nurselineDescrptionLabel: UILabel!
  @IBOutlet weak var scrollViewBG: UIScrollView!
  @IBOutlet weak var scrollviewMainView: UIView!
  @IBOutlet weak var newMedicationDescrptionLabel: UILabel!
  @IBOutlet weak var helpLineView: UIView!
  @IBOutlet weak var addReminderView: UIView!
  @IBOutlet weak var medicationsHeaderTitle: UILabel!
  @IBOutlet weak var reminderView: UIView!
  @IBOutlet weak var addMedsTableview: UITableView!
  @IBOutlet weak var reminderTimeCollectionView: UICollectionView!
  @IBOutlet weak var medsCurveView: UIView!
  let id =  UUID().uuidString
  var medicineDataModel = MedicineDataManager()
  var selectedRows:[IndexPath] = []
  let noOfPrescrption = 4
  @IBOutlet weak var tableviewHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var dynamicWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var dynamicHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var reminderCollectionWidth: NSLayoutConstraint!
    @IBOutlet weak var reminderCollectionHeight: NSLayoutConstraint!

    let plusReminderText = "+"
    var collectionViewReminderLabels: [String] = []
    var reminderList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewReminderLabels = ["02:00 PM", "03:00 PM","04:00 PM", "05:00 PM","06:00 PM", "07:00 PM","08:00 PM"]
        updateCollectionViewSize()
        // fetch reminder list from defaults
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            var existingReminders = ["02:00 PM", "03:00 PM","04:00 PM", "05:00 PM","06:00 PM", "07:00 PM","08:00 PM"]
            self.loadReminders(list: existingReminders, reloadEnable: true)
        }
    }
    
    func loadReminders(list: [String], reloadEnable: Bool) {
        reminderList = list
        collectionViewReminderLabels = reminderList
        collectionViewReminderLabels.append(plusReminderText)
        if reloadEnable {
            DispatchQueue.main.async {
                debugPrint("REM>> reload load reminders")
                self.reminderTimeCollectionView.reloadData()
            }
        }
        //save to defaults
    }
    
    func addNewReminder(title: String) {
        debugPrint("REM>> add new reminder")
        var reminders = self.reminderList
        reminders.append(title)
        loadReminders(list: reminders, reloadEnable: true)
    }
    
    func updateCollectionViewSize() {
        debugPrint("REM>> update collection viewsize")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let itemWidth = (reminderTimeCollectionView.frame.width - 30) / 3.0
        let itemHeight = reminderTimeCollectionView.frame.height / 3.0
        let itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.itemSize = itemSize
        
        let contentWidth = reminderTimeCollectionView.frame.width - reminderTimeCollectionView.contentInset.left - reminderTimeCollectionView.contentInset.right
        let interItemSpacing: CGFloat = 0
        let itemsPerRow = max(floor(contentWidth / (itemSize.width + interItemSpacing)), 1)
        let numberOfRows = ceil(CGFloat(collectionViewReminderLabels.count) / itemsPerRow)
        let height = (itemSize.height + interItemSpacing) * numberOfRows
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Set the section inset
        
        reminderCollectionHeight.constant = height
        dynamicHeightConstraint.constant = height
        reminderTimeCollectionView.collectionViewLayout = layout
        reminderTimeCollectionView.frame.size.height = height
    }
    
    func updatetheMedicinesInfo() -> () {
        medicineDataModel.medicineArray = MedicineDataManager.shared.selectedMedDetails() ?? []
        reloadTableViewData()
    }
  
  override func viewWillAppear(_ animated: Bool) {
    applyBGColorCornerRadius()
    tableViewRegisterNib()
    registerCollectionView()
    applyHelpLineViewBoader()
    applyReminderViewCornerRadius()
    applyLineHeightMultipleLabel()
    updatetheMedicinesInfo()
    updateYourMedicationLabelText()
    newPrescriptionViewSetup()
    notificationCenterAddObserver()
  }
  
  func notificationCenterAddObserver() {
    NotificationCenter.default.addObserver(self, selector: #selector(self.updateView), name: UIApplication.didBecomeActiveNotification, object: nil)
  }
 
  @objc func updateView() {
    newPrescriptionViewSetup()
  }
  
  func applyBGColorCornerRadius() {
    view.backgroundColor = AnthemColor.tabBarDarkGrayColour
    medsCurveView.layer.cornerRadius = 45
    scrollViewBG.layer.cornerRadius = 45
  }
  
  func updateYourMedicationLabelText() {
    yourMedicationHeaderLable.text = medicineDataModel.medicineArray.count <= 0 ?  MedicineDataManager.shared.noMedicationHeaderTitle :  MedicineDataManager.shared.medicationsAppearHeaderTitle
    newMedicationDescrptionLabel.text = medicineDataModel.medicineArray.count <= 0 ?  MedicineDataManager.shared.noMedicationDescription :  MedicineDataManager.shared.medicationsAppearDescription
    newMedicationDescrptionLabel.font =  medicineDataModel.medicineArray.count <= 0 ? UIFont(name: "ElevanceSans-Medium", size: 15) :  UIFont(name: "ElevanceSans-Medium", size: 14)
  }
  
    @IBAction func addReminderButton(_ sender: Any) {
        showReminderScreen()
        
    }
    
    func showReminderScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let addReminderController = storyboard.instantiateViewController(withIdentifier: "AddReminderViewController") as? AddReminderViewController {
            addReminderController.reminderTimeDelegate = self
            addReminderController.reminderSlotDelegate = self
            self.navigationController?.pushViewController(addReminderController, animated: true)
        }
    }
  
  func scheduleNotification(){
    NotificationManager.shared.requestForNotification()
  }
  
  func showNotification(){
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.requestAuthorization(options: [.alert, .sound]) { allowed, error in
      if allowed {
        print("permission granted")
      } else {
        print("error occured ")
      }
      let clearAction = UNNotificationAction(identifier: "ClearNotif", title: "Clear", options: [])
      let category = UNNotificationCategory(identifier: "ClearNotifCategory", actions: [clearAction], intentIdentifiers: [], options: .customDismissAction)
      notificationCenter.setNotificationCategories([category])
      let content = self.getNotificationContent()
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
      let request = UNNotificationRequest(identifier: "1008", content: content, trigger: trigger)
      notificationCenter.add(request){ (error) in
        print("Error \(error?.localizedDescription ?? "")")
      }
    }
  }
  
  func getNotificationContent() -> UNMutableNotificationContent {
    let content = UNMutableNotificationContent()
    content.title = NotificationContent.title
    content.body = NotificationContent.body
    content.sound = .default
    content.categoryIdentifier = "ClearNotifCategory"
    return content
  }
  
  func applyLineHeightMultipleLabel() {
    newMedicationDescrptionLabel.attributedText = self.newMedicationDescrptionLabel.updateLineHeightMultipleLabel(with: newMedicationDescrptionLabel.text ?? "")
    nurselineDescrptionLabel.attributedText = self.nurselineDescrptionLabel.updateLineHeightMultipleLabel(with: nurselineDescrptionLabel.text ?? "" , lineHeight: 1.4)
  }
  
  func newPrescriptionViewUpdateLablesMultiline() {
    newPrescriptionDescrptionLabel.attributedText = self.newPrescriptionDescrptionLabel.updateLineHeightMultipleLabel(with: newPrescriptionDescrptionLabel.text ?? "", lineHeight: 1.4 )
    newPrescriptionHeaderTitleLabel.attributedText = self.newPrescriptionHeaderTitleLabel.updateLineHeightMultipleLabel(with: newPrescriptionHeaderTitleLabel.text ?? "" , lineHeight: 1.4)
  }
  
  func applyReminderViewCornerRadius() {
    addReminderView.layer.cornerRadius = 10
  }
  
  func applyHelpLineViewBoader() {
    helpLineView.layer.cornerRadius = 10
    helpLineView.layer.borderWidth = 2
    helpLineView.layer.borderColor = AnthemColor.colorFromHex("#F7F4FF").cgColor
  }
  
  
  @IBAction func callButtonAction(_ sender: Any) {
  }
  
  @objc func afterThreeSecondsNewPrescriptionViewApperies() {
    newPrescriptionViewAnimation()
    notificationIcon(index: 2, noOfNotifications: noOfPrescrption)
  }
  
  func newPrescriptionViewAnimation(isActive: Bool = true, prescriptionviewY: CGFloat = -120, scrollViewMainViewY: CGFloat = -209.0, toastDispaly: Bool = false) {
    self.prescriptionMainView.alpha =  isActive ? 0 : 1
    self.prescriptionMainView.transform = CGAffineTransform(translationX: 1, y: prescriptionviewY)
    self.scrollviewMainView.transform = CGAffineTransform(translationX: 1, y: scrollViewMainViewY)
    newPrescriptionPopUp(isAvaliable:  isActive)
    UIView.animate(withDuration: 2, delay: 0.0, options: .transitionCurlUp, animations: {
      if toastDispaly {
        self.showToast(message: "Added \(self.selectedRows.count > 1 ? self.selectedRows.count : 1) new prescription")
        LocalStorageManager.setMedsNewPrescription(status: true)
      }
      self.prescriptionMainView.alpha = isActive ? 1 : 0
      self.prescriptionMainView.transform = CGAffineTransform(translationX: 1, y: prescriptionviewY == -200 ? prescriptionviewY : 1)
      self.scrollviewMainView.transform = CGAffineTransform(translationX: 1, y: 1)
    }, completion: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
     removeNotification()
   }

  
  func removeNotification() {
    for subview in tabBarController!.tabBar.subviews {
      if let subview = subview as? UIView {
        if subview.tag == 1234 {
          subview.removeFromSuperview()
          return
        }
      }
    }
  }
  
  func notificationIcon(index: Int, noOfNotifications: Int = 4) {
    let TabBarItemCount = CGFloat(self.tabBarController!.tabBar.items!.count)
    let screenSize = UIScreen.main.bounds
    let HalfItemWidth = (screenSize.width) / (TabBarItemCount * 2)
    let  xOffset = HalfItemWidth * CGFloat(index * 2 + 1)
    let imageHalfWidth: CGFloat = (self.tabBarController!.tabBar.items![index]).selectedImage!.size.width / 2
    let redDot = UIView(frame: CGRect(x: xOffset + imageHalfWidth - 27, y: 4, width: 18, height: 18))
    redDot.tag = 1234
    redDot.backgroundColor = UIColor(patternImage: UIImage(named: medicineDataModel.notificationImg)!)
    let numberText = UILabel(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
    numberText.text = "\(noOfNotifications)"
    numberText.font = UIFont.semiBold(ofSize: 12)
    numberText.textAlignment = .center
    numberText.textColor = UIColor.white
    redDot.addSubview(numberText)
    self.tabBarController?.tabBar.addSubview(redDot)
  }
  
  func newPrescriptionViewSetup() {
    self.prescriptionMainView.alpha = 0
    self.notFountPrescriptionConstrain.constant = 170
    newPrescriptionPopUp()
    newPrescriptionViewCornerRadiusShadow()
    prescriptionButtonCornerRadius()
    newPrescriptionTableViewRegisterNib()
    newPrescriptionViewUpdateLablesMultiline()
    addPrescriptionButtonOutlet.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    addPrescriptionButtonOutlet.setTitle(medicineDataModel.NoSelectedMedsTitle, for: .normal)
    addPrescriptionButtonOutlet.setTitleColor(AnthemColor.highLightedDateTextColor, for: .normal)
    addPrescriptionButtonOutlet.isUserInteractionEnabled = false
    displayFoundNewPresciptionInfo(number: noOfPrescrption)
    if LocalStorageManager.fetchMedsNewPrescription() {
      return
    }

    Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.afterThreeSecondsNewPrescriptionViewApperies), userInfo: nil, repeats: false)
  }
  
  func displayFoundNewPresciptionInfo(number: Int) {
    newPrescriptionDescrptionLabel.text = "We found \(number) new prescription based on your recent claims data:"
  }
  
  func newPrescriptionPopUp(isAvaliable: Bool = false) {
    notFountPrescriptionConstrain.isActive = !isAvaliable
    newPrescriptionFoundConstrain.isActive = isAvaliable
  }
  
  func newPrescriptionViewCornerRadiusShadow() {
    prescriptionMainView.layer.cornerRadius = 20
  }
  
  
  func prescriptionButtonCornerRadius() {
    addPrescriptionButtonOutlet.layer.cornerRadius = 10
    dontAddPrescriptionButtonOutlet.layer.cornerRadius = 10
  }
  
  func newPrescriptionTableViewRegisterNib() {
    newPrescriptionTableview.register(UINib(nibName: "NewPrescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "NewPrescriptionTableViewCell")
  }
  
  @IBAction func addPrescriptionButtonAction(_ sender: Any) {
    removeNotification()
    for (index, _) in selectedRows.enumerated() {
      medicineDataModel.medicineArray.insert(MedicinesViewModel(id: index, title: "Fancy Medication", subTitle: "160mg oral tablet", prescription: "Dr.Judy Jones on July 21,2022", date: "31/01/2023", address: "Pharmacy Name on Jan 31 ,2023, 3170 Abrams Drive Twinsburg,Ohio,44087" , notes: "General tablet4444", condition: "Every Day Morning 444"), at: 0)
    }
    MedicineDataManager.shared.updateselectedMedInformation(updateMedInfo: medicineDataModel.medicineArray)
    newPrescriptionViewAnimation(isActive: false, prescriptionviewY: -200, scrollViewMainViewY: 191, toastDispaly: true)
    reloadTableViewData()
  }
    
    func updateFrame(){
       // reminderCollectionHeight.constant = reminderTimeCollectionView.contentSizeHeight
    }
  
  @objc func reloadTableViewData() {
    addMedsTableview.reloadData()
    tableviewHeightAnchor.constant = addMedsTableview.contentSizeHeight
  }
  
  @IBAction func dontAddPrescriptionButtonAction(_ sender: Any) {
    removeNotification()
    LocalStorageManager.setMedsNewPrescription(status: true)
    newPrescriptionViewAnimation(isActive: false, prescriptionviewY: -200, scrollViewMainViewY: 191)
  }
  
  
  func tableViewRegisterNib() {
    addMedsTableview.register(UINib(nibName: "ListOfAddMedicationTableViewCell", bundle: nil), forCellReuseIdentifier: "ListOfAddMedicationTableViewCell")
  }
    func registerCollectionView() {
     //   reminderTimeCollectionView.backgroundColor = AnthemColor.collectionViewBackgroundColor
      reminderTimeCollectionView.register(UINib(nibName: "AddReminderCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddReminderCellCollectionViewCell")
    }
  
  
  override func viewDidLayoutSubviews() {
    tableviewHeightAnchor.constant = addMedsTableview.contentSizeHeight
    newPrescriptionTableviewHeightConstrain.constant = newPrescriptionTableview.contentSizeHeight
  }
  
    @IBAction func addMedsAction(_ sender: Any) {
      ActivityIndicator.showActivityIndicator(uiView: self.view, fromTabBar: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            ActivityIndicator.hideActivityIndicator(uiView: self.view)
            if let addMedsViewController = WeeklyPlantSB.instantiateViewController(withIdentifier: "AddMedsViewController") as? AddMedsViewController {
                addMedsViewController.medDetailDelegate = self
                self.navigationController?.pushViewController(addMedsViewController, animated: true)
            }
        }
    }
}

extension MedsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == addMedsTableview {
      return medicineDataModel.medicineArray.count
    } else {
      return noOfPrescrption
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if tableView == addMedsTableview {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfAddMedicationTableViewCell") as? ListOfAddMedicationTableViewCell
      cell?.addMedsHeaderTitle.text = medicineDataModel.medicineArray[indexPath.row].title
      cell?.addMedsDescrptionLabel.text = medicineDataModel.medicineArray[indexPath.row].subTitle
      cell?.addMedsBGView.backgroundColor = AnthemColor.colorFromHex("#F9FAFB")
      cell?.addMedsBGView.layer.cornerRadius = 15
      return cell!
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "NewPrescriptionTableViewCell") as? NewPrescriptionTableViewCell
      cell?.newPrescriptionSelectionButton.addTarget(self, action: #selector(selectTickButtonAction) , for: .touchUpInside)
      if noOfPrescrption > 1 {
        cell?.buttonWidthConstraint.constant = 18
        cell?.newPrescriptionSelectionButton.isHidden = false
        cell?.newPrescriptionSelectionButton.setImage(UIImage(named: medicineDataModel.squarTickImg), for: .selected)
        cell?.newPrescriptionSelectionButton.setImage(UIImage(named: medicineDataModel.squarUnTickImg), for: .normal)
        cell?.newPrescriptionSelectionButton.tag = indexPath.row
      } else {
        cell?.buttonWidthConstraint.constant = 0
        addPrescriptionButtonOutlet.isUserInteractionEnabled = true
        addPrescriptionButtonOutlet.setTitle(medicineDataModel.addMedsTitle, for: .normal)
        addPrescriptionButtonOutlet.backgroundColor = UIColor.white
      }
       return cell!
    }
  }
  
  @objc func selectTickButtonAction(sender: UIButton) {
    sender.isSelected = !sender.isSelected
    let selectedIndexPath = IndexPath(row: sender.tag, section: 0)
    if self.selectedRows.contains(selectedIndexPath) {
      self.selectedRows.remove(at: self.selectedRows.firstIndex(of: selectedIndexPath)!)
    } else {
      self.selectedRows.append(selectedIndexPath)
    }
    self.addPrescriptionButtonOutlet.setTitle("Add \(self.selectedRows.count) Meds", for: .normal)
    addPrescriptionButtonOutlet.backgroundColor = UIColor.white
    addPrescriptionButtonOutlet.isUserInteractionEnabled = true
    if selectedRows.count <= 0 {
      addPrescriptionButtonOutlet.isUserInteractionEnabled = false
      addPrescriptionButtonOutlet.setTitle(medicineDataModel.NoSelectedMedsTitle, for: .normal)
      addPrescriptionButtonOutlet.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }
  }
  
  func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if tableView == addMedsTableview {
      if let medicationDetailsViewController = MainSB.instantiateViewController(withIdentifier: "MedicationDetailsViewController") as? MedicationDetailsViewController {
        medicationDetailsViewController.selectedIndex = indexPath.row
        medicationDetailsViewController.delegate = self
        medicationDetailsViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(medicationDetailsViewController, animated: true)
      }
    }
  }
}

extension UITableView {
  var contentSizeHeight: CGFloat {
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

extension MedsViewController: MedsDetailProtocal, AddReminderTimeSelectionProtocol {
  func userDeletedItem(info: String,medArray : [MedicinesViewModel]) {
      var computedString = ""
      if info.count > 16{
          computedString = info.prefix(16) + ".."
      }
      else{
          computedString = info
      }
    showToast(message: "\(computedString) was removed", fontSize: 16)
    medicineDataModel.medicineArray = medArray
    updateYourMedicationLabelText()
    addMedsTableview.reloadData()
  }
    
    func didSelectTime(hour: Int, minute: Int) {
        NotificationTimeComponent.hour = hour
        NotificationTimeComponent.minute = minute
       
    }
}

extension MedsViewController : AddMedsDetailProtocal {
  func selected(info: Int, title: String, moreThanOne: Bool) {
    if moreThanOne {
      self.showToast(message: "\(info) Medications Added")
    } else {
        var computedString = ""
        if title.count > 20{
            computedString = title.prefix(20) + ".."
        }
        else{
            computedString = title
        }
      self.showToast(message: "\(computedString) Added")
    }
  }
}

extension MedsViewController:UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,AddReminderSlotsProtocol {
    
    func didSelectedReminder(reminderGroup: String) {
        addNewReminder(title: reminderGroup)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        debugPrint("REM>> collectionViewReminderLabels \(collectionViewReminderLabels)")
        debugPrint("REM>> collectionViewReminderLabels.count \(collectionViewReminderLabels.count)")
        return collectionViewReminderLabels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        debugPrint("REM>> cellForItemAt \(indexPath)")

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddReminderCellCollectionViewCell", for: indexPath) as? AddReminderCellCollectionViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.reminderTimeButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let titleText = collectionViewReminderLabels[indexPath.row]
        cell.reminderTimeButton.setTitle(titleText, for: .normal)
        if  cell.reminderTimeButton.titleLabel?.text == plusReminderText {
            cell.reminderTimeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       if let cell = collectionView.cellForItem(at: indexPath) as? AddReminderCellCollectionViewCell  {
           if  cell.reminderTimeButton.titleLabel?.text == plusReminderText {
               showReminderScreen()
           }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddReminderCellCollectionViewCell", for: indexPath) as? AddReminderCellCollectionViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.reminderTimeButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let titleText = collectionViewReminderLabels[indexPath.row]
        cell.reminderTimeButton.setTitle(titleText, for: .normal)
        let labelSize = cell.reminderTimeButton.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: 14))
        
        return CGSize(width: labelSize.width + 30, height: 50)
    }

    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5);
    }
}

