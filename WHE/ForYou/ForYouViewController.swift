//
//  ForYouViewController.swift
//  ShareCareTabBar
//
//  Created by Venkateswarlu Samudrala on 09/01/23.
//

import UIKit


class ForYouViewController: UIViewController {
  @IBOutlet weak var editWeekPlanButtonOutlet: UIButton!
  @IBOutlet weak var checkinTable: UITableView!
  @IBOutlet weak var checkinTimeView: UIView!
  @IBOutlet weak var mainGradientView: UIView!
  @IBOutlet weak var completeLbl: UILabel!
  @IBOutlet weak var addLbl: UILabel!
  @IBOutlet weak var letsGoView: UIView!
  @IBOutlet weak var gradientView: UIView!
  @IBOutlet weak var forYouActivityCenterView: UIView!
  @IBOutlet weak var unlockView: UIView!
  @IBOutlet weak var unlockTextLabel: UILabel!
  @IBOutlet weak var forYouCurveView: UIView!
  @IBOutlet weak var getFreeTrackerView: UIView!
  @IBOutlet weak var getFreeTrackerDescription: UILabel!
  @IBOutlet weak var getFreeTrackerHeaderTitle: UILabel!
  @IBOutlet weak var importYourMedsHeaderTitle: UILabel!
  @IBOutlet weak var importYourMedsDescription: UILabel!
  @IBOutlet weak var getFreeTrackerButtonOutlet: UIButton!
  @IBOutlet weak var importYourMedsButtonOutlet: UIButton!
  @IBOutlet weak var getFreeTrackerNotNowOutlet: UIButton!
  @IBOutlet weak var medsNotNowButtonOutlet: UIButton!
  @IBOutlet weak var calendarView: UIView!
  @IBOutlet weak var completeStatusLabel: UILabel!
  @IBOutlet weak var checkImageView: UIImageView!
  @IBOutlet weak var currentDateTextLabel: UILabel!
  @IBOutlet weak var completeHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var checkImageConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var confirmEmailPickAFocusAreaMainView: UIView!
  
  @IBOutlet weak var footerViewHeaderTitle: UILabel!
  @IBOutlet weak var footerViewImage: UIImageView!
  @IBOutlet weak var emailConfirmTableview: UITableView!
  @IBOutlet weak var footerViewBG: UIView!
  
  @IBOutlet weak var rewardsView: UIView!
  @IBOutlet weak var profileIcon: UIImageView!
  
  @IBOutlet weak var rewardsImageview: UIImageView!
  @IBOutlet weak var rewardsPointsLabel: UILabel!
  
    let confirmEmailViewModel = ConfirmEmailPickFocuseAreaViewModel()
    let readStepsViewModel = HealthKitReadStepsInfoViewModel()

    var isShowToast: Bool = true
    static var medCount: Int?
    var stepsCountforOneDay: Double?
    static var fromForYouScreen: Bool = false
     var displayNameArr: [String] = []
    let trackMeds =  "trackMeds"
    let trackSteps =  "TrackSteps"
    let pickCheck =  "PickCheck"

  override func viewDidLoad() {
    super.viewDidLoad()
   isUserVerified()
    if LocalStorageManager.fetchLetsGo(){
      self.mainGradientView.isHidden = true
      self.gradientView.isHidden = true
      
    }
    else {
      self.style = .lightContent
      self.tabBarController?.tabBar.isHidden = true
    }
    setupConfirmEmailPickupFocuseAreaMainView()
    setupView()
    setupCheckinTimeView()
    addDisplayNameIntoArr()
    gettingStepsCount()
    if LocalStorageManager.fetchEditWeeklyPlanOnBoarding() {
      checkinTimeView.isHidden = false
    } else {
      checkinTimeView.isHidden = true
    }
  }
    
    func addDisplayNameIntoArr()
    {
        if LocalStorageManager.fetchTrackYourMeds() {
            displayNameArr.append(trackMeds)
        }
        if LocalStorageManager.fetchTrackYourSteps() {
            displayNameArr.append(trackSteps)

        }
       if !LocalStorageManager.fetchCheckinTime()
        {
            displayNameArr.append(pickCheck)
        }
    }
  
    func isUserVerified(){
   
        ApolloClientManager.shared.getEmailConfirmation { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                LocalStorageManager.setConfirmEmail(status: true)
                debugPrint(response)
                self.emailConfirmTableview.reloadData()
            case .failure(let error):
                debugPrint("Get Consent url fetch error: \(error)")
            }
        }
    }
    func setupCheckinTimeView() {
        registerCheckinCell()
    }
  
  func setupConfirmEmailPickupFocuseAreaMainView() {
      registerCell()
    addCornerRadiusFooterView()
    applyCornerRadiusView()
    setupFooterView()
    setuRewardsPointView()
    profileItemSetup()
  }
  
  func profileItemSetup() {
    profileIcon.layer.cornerRadius = 17
    profileIcon.layer.borderWidth = 1
    profileIcon.layer.borderColor = AnthemColor.colorFromHex("231E33").withAlphaComponent(0.25).cgColor
  }
  
  func setupFooterView() {
    self.footerViewBG.layer.borderWidth = 1
    self.footerViewBG.layer.borderColor = AnthemColor.colorFromHex("231E33").withAlphaComponent(0.04).cgColor
    self.footerViewBG.backgroundColor = UIColor(patternImage: UIImage(named: "for_you_header_background")!)
    self.footerViewBG.layer.cornerRadius = 10
    self.footerViewHeaderTitle.attributedText = footerViewHeaderTitle.updateLineHeightMultipleLabel(with: self.footerViewHeaderTitle.text ?? "", lineHeight: 1.32)
  }
  
  func setuRewardsPointView() {
    self.rewardsView.backgroundColor = UIColor(patternImage: UIImage(named: "gradient_balance")!)
  }
    
    func applyCornerRadiusView() {
        self.confirmEmailPickAFocusAreaMainView.layer.cornerRadius = 45
        self.checkinTimeView.layer.cornerRadius = 45
    }
  
  @IBAction func editWeekPlanButtonAction(_ sender: Any) {
    yourWeelyPlanVC()
  }
    
  func gettingStepsCount(){
            readStepsViewModel.getStepsCountData(completion: { (stepsCount) in
          print("Step count: \(stepsCount)")
                self.stepsCountforOneDay = stepsCount
            if  stepsCount >= 5000{
                LocalStorageManager.setTrackYourStepsDone(status: true)
            }
        })
    }
  
  func yourWeelyPlanVC() {
    if let importMedsViewController = WeeklyPlantSB.instantiateViewController(withIdentifier: "YourWeeklyPlanViewController") as? YourWeeklyPlanViewController {
      self.navigationController?.pushViewController(importMedsViewController, animated: true)
    }
  }
  
    func registerCheckinCell() {
        let pickCheckinTimeTableViewCell = UINib(nibName: "PickCheckinTimeTableViewCell", bundle: nil)
        self.checkinTable.register(pickCheckinTimeTableViewCell, forCellReuseIdentifier: "PickCheckinTimeTableViewCell")
        
        let trackYourStepCell = UINib(nibName: "TrackYourStepCell", bundle: nil)
        self.checkinTable.register(trackYourStepCell, forCellReuseIdentifier: "TrackYourStepCell")
        let trackMedsCell = UINib(nibName: "TrackMedsCell", bundle: nil)
        self.checkinTable.register(trackMedsCell, forCellReuseIdentifier: "TrackMedsCell")
    }
    
    func registerCell() {
         let emailFocusTableViewCell = UINib(nibName: "EmailFocusAreaTableViewCell", bundle: nil)
        self.emailConfirmTableview.register(emailFocusTableViewCell, forCellReuseIdentifier: "EmailFocusAreaTableViewCell")
    }
  
  func addCornerRadiusFooterView() {
    self.footerViewBG.layer.cornerRadius = 10
  }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailConfirmTableview.reloadData()
        setGradientBackground()
        setNeedsStatusBarAppearanceUpdate()
        if ForYouViewController.medCount == 0 || ForYouViewController.medCount != nil {
            if ForYouViewController.fromForYouScreen {
                showMedicationCompletionStatus()
            }
            showMedicationCompletionStatus()
        } else {
            if UserDefaults.standard.bool(forKey: MedicineStates.kNotNowOptionSelected){
                skipMedication()
            } else {
                self.checkImageView.isHidden = true
                self.completeStatusLabel.isHidden = true
            }
        }
    }
    
    func setGradientBackground() {
        let normalFont = UIFont.mediumBold(ofSize: 16)
        let boldSearchFont = UIFont.semiBold(ofSize: 16)
        addLbl.attributedText = addLbl.updateLineHeightMultipleLabel(with: addLbl.text ?? "", lineHeight: 1.32)
        self.addLbl.attributedText = addBoldText(fullString: "We’ve added some steps for you to \n start with to get your first reward.", boldPartsOfString: ["some steps"], font: normalFont, boldFont: boldSearchFont)
        self.completeLbl.attributedText = addBoldText(fullString: "Complete your first steps to earn a bonus reward of $10!", boldPartsOfString: ["first steps","bonus reward of $10!"], font: normalFont, boldFont: boldSearchFont)
        letsGoView.layer.cornerRadius = 20.0
        letsGoView.clipsToBounds = true
        let colorTop =  UIColor(red: 35.0/255.0, green: 30.0/255.0, blue: 51.0/255.0, alpha: 0.6).cgColor
        let colorBottom = UIColor(red: 35.0/255.0, green: 30.0/255.0, blue: 51.0/255.0, alpha: 0.9).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
//        gradientLayer.locations = [0.0 , 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = self.view.bounds
        self.gradientView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func setupView(){
        applyRoundCorners()
        setupUnlockViews()
        setupTrackerViews()
        setupMedsTrackerViews()
        setupCalendarView()
        currentDateTextLabel.text = getCurrentDay()
        setupGetFreeTrackerDescriptionLabel()
    }
    
  override func viewDidLayoutSubviews() {
    if isShowToast {
      displayToastAlert()
    } else {
      if confirmEmailPickAFocusAreaMainView.isHidden == true {
        self.checkImageView.isHidden = false
        self.completeStatusLabel.isHidden = false
      }
    }
  }
  
    @IBAction func onClickLetsGo(_ sender: Any) {
        LocalStorageManager.setLetsGo(status: true)
        tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.isHidden = false
        self.mainGradientView.isHidden = true
        self.gradientView.isHidden = true
      if self.style == .lightContent {
        self.style = .default
      } else {
        self.style = .lightContent
      }
      setNeedsStatusBarAppearanceUpdate()
        setupView()
    }
    
  func addBoldText(fullString: NSString, boldPartsOfString: Array<NSString>, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
        let boldFontAttribute = [NSAttributedString.Key.font:boldFont]
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        paragraphStyle.alignment = .center
        let attributes = [NSAttributedString.Key.font:font, NSAttributedString.Key.paragraphStyle:paragraphStyle]
        let boldString = NSMutableAttributedString(string: fullString as String, attributes:attributes)
        for i in 0 ..< boldPartsOfString.count {
            boldString.addAttributes(boldFontAttribute, range: fullString.range(of: boldPartsOfString[i] as String))
        }
        return boldString
    }
    
  func displayToastAlert(){
    if ForYouViewController.medCount != nil {
      showMedicationCompletionStatus()
      isShowToast = false
    } else {
      self.checkImageView.isHidden = true
      self.completeStatusLabel.isHidden = true
    }
  }
  
  func showMedicationCompletionStatus(){
    if let medicationCount = ForYouViewController.medCount {
        
      if ForYouViewController.fromForYouScreen {
        if !LocalStorageManager.fetchMedicineSaved() {
              let toastMessage = "Imported \(medicationCount) medications"
              self.showToast(message:toastMessage,fontSize: 16)
              ForYouViewController.fromForYouScreen = false
        }
      }
      if medicationCount >= 0 {
        disableImportMedication()
        completeMedication()
      } else {
        showImportedMedication(status: true)
        importOption(isHidden: false)
        updateConstraintsForStatus(constraintConstant: 60)
      }
    }
  }
  
  func disableImportMedication() {
    self.completeHeightConstraint.constant = 8
    self.checkImageConstraint.constant = 8
    importOption(isHidden: true)
    showImportedMedication(status: false)
    updateConstraintsForStatus(constraintConstant: 8)
  }
  
  func importOption(isHidden:Bool) {
    self.importYourMedsButtonOutlet.isHidden = isHidden
    self.medsNotNowButtonOutlet.isHidden = isHidden
    self.importYourMedsDescription.isHidden = isHidden
  }
  
  func showImportedMedication(status: Bool){
    if confirmEmailPickAFocusAreaMainView.isHidden == true {
      self.checkImageView.isHidden = status
      self.completeStatusLabel.isHidden = status
    }
  }
  
  func updateConstraintsForStatus(constraintConstant: CGFloat){
    self.completeHeightConstraint.constant = constraintConstant
    self.checkImageConstraint.constant = constraintConstant
  }
  
  func applyRoundCorners() {
     forYouCurveView.layer.cornerRadius = 45
  }
    
  func getCurrentDay() -> String {
    return "For" + " " + CalendarHelper().getCurrentDay(date: selectedDate) + ", " + CalendarHelper().monthString(date: selectedDate) + " " + String(CalendarHelper().dayOfMonth(date: selectedDate))
  }
  
  func setupTrackerViews() {
    self.getFreeTrackerButtonOutlet = applyCornerRadiusForButton(cornerButton: getFreeTrackerButtonOutlet)
    self.getFreeTrackerNotNowOutlet = applyCornerRadiusForButton(cornerButton: getFreeTrackerNotNowOutlet)
  }
  
  func setupMedsTrackerViews() {
    self.importYourMedsButtonOutlet = applyCornerRadiusForButton(cornerButton: importYourMedsButtonOutlet)
    self.medsNotNowButtonOutlet = applyCornerRadiusForButton(cornerButton: medsNotNowButtonOutlet)
  }
  
  func setupGetFreeTrackerDescriptionLabel() {
    getFreeTrackerDescription.attributedText = attributedString(textString: getFreeTrackerDescription.text ?? "")
    importYourMedsDescription.attributedText = attributedString(textString: importYourMedsDescription.text ?? "")
  }
  
  func setupUnlockViews() {
    unlockTextLabel.attributedText = attributedString(lineSpacing: 3.0, textString: unlockTextLabel.text ?? "")
    unlockView.layer.cornerRadius = 10
    unlockView.layer.borderWidth = 2
    unlockView.layer.borderColor = AnthemColor.unlockViewBoaderColour.cgColor
  }
  
  func setupCalendarView(){
    let week = CalendarWeek()
    self.calendarView.addSubview(week)
    week.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      week.bottomAnchor.constraint(equalTo: self.calendarView.bottomAnchor, constant: -10),
      week.leadingAnchor.constraint(equalTo: self.calendarView.leadingAnchor, constant: 20),
      week.trailingAnchor.constraint(equalTo: self.calendarView.trailingAnchor, constant: -20)
    ])
  }
  
  func applyCornerRadiusForButton(radius: CGFloat = 10, cornerButton: UIButton) -> UIButton {
    cornerButton.layer.cornerRadius = radius
    cornerButton.layer.masksToBounds = true
    return cornerButton
  }
  
  @IBAction func getFreeTrackerButtonAction(_ sender: Any) {
    
  }
  
  @IBAction func getFreeTrackerNotNowAction(_ sender: Any) {
      
  }
  
    @IBAction func medsNotNowAction(_ sender: Any) {
        isShowToast = false
        disableImportMedication()
        medsNotNowButtonOutlet.isSelected = !medsNotNowButtonOutlet.isSelected
        UserDefaults.standard.set((sender as AnyObject).isSelected, forKey: MedicineStates.kNotNowOptionSelected)
        if medsNotNowButtonOutlet.isSelected {
            skipMedication()
        }
    }
    
  @IBAction func medsButtonAction(_ sender: Any) {
  }
  
  func skipMedication(){
    self.completeStatusLabel.text = "Skipped"
    self.completeStatusLabel.textColor = AnthemColor.DayTextColor
    self.checkImageView.image = UIImage(named:"skip")
  }
  
  func completeMedication(){
    self.checkImageView.image = UIImage(named: "check_circle")
    self.completeStatusLabel.text = "Completed"
    self.completeStatusLabel.textColor = AnthemColor.completedStatusColor
  }
    
  override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }
  
    var style:UIStatusBarStyle = .default

  
  func hideImportMedicine(isHidden: Bool){
    self.importYourMedsHeaderTitle.isHidden = isHidden
    self.importYourMedsDescription.isHidden = isHidden
    self.importYourMedsButtonOutlet.isHidden = isHidden
    self.medsNotNowButtonOutlet.isHidden = isHidden
  }
  
  func attributedString(lineSpacing: Double = 5.24, textString: String) -> NSMutableAttributedString {
    let attributedString = NSMutableAttributedString(string: textString)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing // Whatever line spacing you want in points
    attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
    return attributedString
  }
}

extension UILabel {
  func addCharacterSpacing(kernValue: Double = 1.24) {
    guard let text = text, !text.isEmpty else { return }
    let string = NSMutableAttributedString(string: text)
    string.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: string.length - 1))
    attributedText = string
  }
}

extension ForYouViewController: UITableViewDataSource, UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == checkinTable {
            return displayNameArr.count
        }
        return confirmEmailViewModel.fetchNumberOfCellDisplay()
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == checkinTable {
            if displayNameArr[indexPath.row] == trackMeds{
                let cell = tableView.dequeueReusableCell(withIdentifier: "TrackMedsCell", for: indexPath) as! TrackMedsCell
                cell.configueCellWithTrackMeds()
                cell.btn_taken.addTarget(self, action: #selector(trackMedsTaken), for: .touchUpInside)

                return cell
            }
            else  if displayNameArr[indexPath.row] == trackSteps{
                let cell = tableView.dequeueReusableCell(withIdentifier: "TrackYourStepCell", for: indexPath) as! TrackYourStepCell
                cell.configueCellWithTrackYourSteps(stepsCount: self.stepsCountforOneDay ?? 0)

                return cell
            }
            else  if displayNameArr[indexPath.row] == pickCheck{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PickCheckinTimeTableViewCell", for: indexPath) as! PickCheckinTimeTableViewCell
                cell.descLbl.attributedText =  cell.descLbl.updateLineHeightMultipleLabel(with:cell.descLbl.text ?? "", lineHeight: 1.24)
                cell.pickBtn.tag = indexPath.row
                cell.pickBtn.addTarget(self, action: #selector(pickCheckinTime), for: .touchUpInside)
                return cell
            }
        
        }
        else
        {
            let confirmation = LocalStorageManager.fetchConfirmEmail()
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmailFocusAreaTableViewCell", for: indexPath) as! EmailFocusAreaTableViewCell
            if confirmation && indexPath.row == 0 {
                cell.emailVerified = true
                confirmEmailViewModel.listOfConfirmEmail[indexPath.row] = ""
            } else {
                cell.emailVerified = false
            }
            cell.headerTitleLabel.text = confirmEmailViewModel.listOfHeaderText[indexPath.row]
            cell.buttonOutlet.setTitle(confirmEmailViewModel.listButtonTitle[indexPath.row], for: .normal)
            cell.descriptionTitleLabel.text = confirmEmailViewModel.listOfConfirmEmail[indexPath.row]
            cell.descriptionTitleLabel.attributedText =  cell.descriptionTitleLabel.updateLineHeightMultipleLabel(with:confirmEmailViewModel.listOfConfirmEmail[indexPath.row], lineHeight: 1.44)
            cell.buttonOutlet.tag = indexPath.row
            cell.buttonOutlet.addTarget(self, action: #selector(emailConfirmPickFocusArea), for: .touchUpInside)
            if indexPath.row == confirmEmailViewModel.fetchNumberOfCellDisplay() - 1 {
                cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0);
            }
            return cell
        }
        
        return  UITableViewCell()
    }
    
    func pickAreaScreen() {
        let vc = PrivacySB.instantiateViewController(withIdentifier: "FocusAreaViewController") as! FocusAreaViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
  
  func ConfirmEmailVerificationScreen() {
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    if let confirmEmailAddressViewController = storyboard.instantiateViewController(withIdentifier: "ConfirmEmailAddressViewController") as? ConfirmEmailAddressViewController {
      confirmEmailAddressViewController.modalPresentationStyle  = .fullScreen
      self.present(confirmEmailAddressViewController, animated: true)
     }
  }
    @objc func trackMedsTaken() {
       yourTakenMeds()
      LocalStorageManager.setTrackYourMedsTaken(status: true)
      checkinTable.reloadData()
   }
    func yourTakenMeds() {
        if let importMedsViewController = WeeklyPlantSB.instantiateViewController(withIdentifier: "TakeYourMedsViewController") as? TakeYourMedsViewController {
            importMedsViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(importMedsViewController, animated: true)
      }
 }
    @objc func pickCheckinTime() {
       //
        checkinTimeView.isHidden = true
    }
  @objc func emailConfirmPickFocusArea(sender: UIButton) {
    if sender.tag == 0 {
      ConfirmEmailVerificationScreen()
    } else {
        pickAreaScreen()
    }
  }
}
