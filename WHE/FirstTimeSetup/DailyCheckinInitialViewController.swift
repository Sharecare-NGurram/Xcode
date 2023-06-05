//
//  DailyCheckinInitialViewController.swift
//  WHE
//
//  Created by Pratima Pundalik on 19/04/23.
//

import UIKit


class DailyCheckinInitialViewController: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dailyCheckinLabel: UILabel!
    @IBOutlet weak var checkinImageView: UIImageView!
    @IBOutlet weak var timeWheel: UIView!
    @IBOutlet weak var skipLaterButton: UIButton!
    @IBOutlet weak var chooseReminderButton: UIButton!
    
    private var dailyCheckinViewModel = DailyCheckinViewModel()
    weak var reminderTimeDelegate: AddReminderTimeSelectionProtocol?
    var defaultHour: Int?
    var defaultMin: Int?
    var defaultHourFormat: HourFormat?

    override func viewDidLoad() {
        super.viewDidLoad()
        applyCornerRadius()
        setDefaultTime()
        setupViews()
        setupEvents()
        setUpDailyCheckin()
        NotificationManager.shared.requestForNotification()
    }
    

    @IBAction func skipLaterAction(_ sender: Any) {
        willDoLaterVC()
        
    }
    
    func willDoLaterVC() {
        LocalStorageManager.setSkipCheckin(status: true)
        if let willDoLaterVC = DailyCheckInDoLaterSB.instantiateViewController(withIdentifier: "DailyCheckInDoLaterViewController") as? DailyCheckInDoLaterViewController {
            self.navigationController?.pushViewController(willDoLaterVC, animated: true)
        }
    }
    
    @IBAction func chooseReminderAction(_ sender: Any) {
        LocalStorageManager.setSkipCheckin(status: false)
        LocalStorageManager.setCheckinTime(status: true)
         let firstTimeVc = firstTimeSetupSB.instantiateViewController(withIdentifier: "FirstTimeSetupViewController" ) as? FirstTimeSetupViewController
        if let firstTimeViewController = firstTimeVc {
           navigationController?.pushViewController(firstTimeViewController, animated: true)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
      .lightContent
    }
    
    func setUpDailyCheckin(){
        dailyCheckinLabel.font = UIFont.semiBold(ofSize: 32)
        dailyCheckinLabel.text = "Daily Check In"
        dailyCheckinLabel.textColor = AnthemColor.enabledDateTextColor
        descriptionLabel.text = "What time would you like us to ask about the progress you made for the day?"
        descriptionLabel.textColor = AnthemColor.DayTextColor
        descriptionLabel.attributedText = descriptionLabel.updateLineHeightMultipleLabel(with: descriptionLabel.text ?? "", lineHeight: 1.32)
        descriptionLabel.textAlignment = .center
        self.skipLaterButton.titleLabel?.font = UIFont.semiBold(ofSize: 17)
        self.skipLaterButton.setTitle(dailyCheckinViewModel.skipLater, for: .normal)
        self.skipLaterButton.setTitleColor(AnthemColor.textBorderColor, for: .normal)
    }
    
    func applyCornerRadius() {
        chooseReminderButton.layer.cornerRadius = 10
        chooseReminderButton.backgroundColor = AnthemColor.colonLabelColor
    }
    private var timePicker: RealTimePickerView = {
        let view = RealTimePickerView(format: .h12)
        view.showUnitSeparator = true
        
        view.rowHeight = 58
        view.timeLabelFont = UIFont.mediumBold(ofSize: 32)
        view.colonLabelFont = UIFont.mediumBold(ofSize: 24)
        view.formatLabelFont = UIFont.mediumBold(ofSize: 32)
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 24
        view.showDefaultDailyCheckinTime = true
        view.showCurrentTime = true
        return view
    }()
    
    private func setupViews() {
        timeWheel.addSubview(timePicker)
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        timePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        LocalStorageManager.setDailyCheckIn(status: false)
        LocalStorageManager.setWillDoLaterChckIn(status: false)
        //timePicker.currentTimeDelegate = self
    }
    private func setupEvents() {
        timePicker.subviews.first?.subviews.last?.isHidden = true
        timePicker.onNumberTimePicked = { hour, minute, hourFormat in
            self.showSelectedTime(hour: hour, minute: minute, hourFormat: hourFormat)
            self.defaultHour = hour
            self.defaultMin = minute
            self.reminderTimeDelegate?.didSelectTime(hour: hour, minute: minute)
        }
    }
    
    func setDefaultTime(){
        let currentTime = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        let hr = timePicker.formattedDefaultHour ?? 1
        self.defaultHour = hr + 12 ?? 0
        self.defaultMin = timePicker.formattedDefaultMin
        
        self.showSelectedTime(hour: timePicker.formattedDefaultHour ?? 1, minute: timePicker.formattedDefaultMin ?? 0, hourFormat: timePicker.defaultHourFormat)
    }
    
    func showSelectedTime(hour:Int, minute: Int, hourFormat: HourFormat) {
        var formattedHour = hour
        var formattedMin = minute
        if minute == 60 {
            formattedHour = formattedHour + 1
            formattedMin = 00
        }
        switch hourFormat {
        case .pm where hour > 12 && hour <= 24:
            formattedHour = hour - 12
        case .am where hour == 12:
            formattedHour = hour
        default:
            break
        }
        showDailyCheckinImage(hour:  formattedHour, minute: formattedMin, hourFormat: hourFormat)
        
        let timeText = [formattedHour, minute].compactMap {
            String(format: "%02d", $0)
        }.joined(separator: ":")
        let timw = "\(formattedHour)" + ":" + String(format: "%02d", formattedMin)
        
        let selectedRemindertime = "Choose  \(timw) \(hourFormat.rawValue) for Check In Time"
        self.chooseReminderButton.titleLabel?.font = UIFont.semiBold(ofSize: 17)
        self.chooseReminderButton.setTitle(selectedRemindertime, for: .normal)
    }
    
    func showDailyCheckinImage(hour:Int, minute: Int, hourFormat: HourFormat) {
        switch hourFormat {
        case .pm where (hour >= 5 && hour <= 11):
            checkinImageView.image = UIImage(named: dailyCheckinViewModel.nightCheckinImage)
            
        case .am where hour == 12 || hour < 5:
            checkinImageView.image = UIImage(named: dailyCheckinViewModel.nightCheckinImage)
            
        case .am where (hour >= 5 && hour <= 11):
            checkinImageView.image = UIImage(named: dailyCheckinViewModel.dayCheckinImage)
            
        case .am where hour == 5 && hour < 12:
            checkinImageView.image = UIImage(named: dailyCheckinViewModel.dayCheckinImage)
            
        case .pm where (hour == 12 || hour < 5):
            checkinImageView.image = UIImage(named: dailyCheckinViewModel.dayCheckinImage)
        default:
            break
        }
        
    }
}
