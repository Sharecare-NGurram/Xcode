//
//  AddReminderViewController.swift
//  WHE
//
//  Created by Pratima Pundalik on 20/02/23.
//

import UIKit

protocol AddReminderTimeSelectionProtocol: class {
    func didSelectTime(hour:Int, minute: Int)
}
protocol AddReminderSlotsProtocol: class {
    func didSelectedReminder(reminderGroup: String)
}

class AddReminderViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var addReminderButton: UIButton!
    
    @IBOutlet weak var timeWheel: UIView!
    weak var reminderTimeDelegate: AddReminderTimeSelectionProtocol?
    weak var reminderSlotDelegate: AddReminderSlotsProtocol?
    var defaultHour: Int?
    var defaultMin: Int?
    var defaultHourFormat: HourFormat?
    var viewModel = RemainderViewModel()
    var timeStr =  ""
    @IBOutlet weak var addTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getRemainderTime()
        print(viewModel.remainderArr )
        applyCornerRadius()
        setDefaultTime()
        setupViews()
        setupEvents()
        let str:String = getnamesLabel()
        print(str)
        NotificationManager.shared.requestForNotification()
    }
    func getnamesLabel()-> String{
        var str:String = ""
        if viewModel.remainderArr.count != 0{
            let formatter = ListFormatter()
             str = "You currently have reminders set for "
            if let string = formatter.string(from: viewModel.remainderArr) {
                str = str + string
            }
            let normalFont = UIFont.mediumBold(ofSize: 16)
            let boldSearchFont = UIFont.semiBold(ofSize: 16)
            self.addTimeLabel.attributedText = addTimeLabel.updateLineHeightMultipleLabel(with: addTimeLabel.text ?? "", lineHeight: 1.32)
            self.addTimeLabel.attributedText = addBoldText(fullString: str as NSString, boldPartsOfString:viewModel.remainderArr , font: normalFont, boldFont: boldSearchFont)

            return str

        }else{
            
            return str

        }
        }
    
    @IBAction func addReminderAction(_ sender: Any) {
        let bool:Bool = viewModel.addRemaiderTime(timeStr: timeStr)
        if bool == false{
            viewModel.remainderArr.append(timeStr)
            self.reminderSlotDelegate?.didSelectedReminder(reminderGroup: timeStr)
            
        }
        viewModel.updateRemainderTime(remainderArr: viewModel.remainderArr )
        let str:String = getnamesLabel()
        print(str)
        NotificationManager.shared.registerNotification(hour: self.defaultHour ?? 0, min: self.defaultMin ?? 00)
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    func applyCornerRadius() {
        addReminderButton.layer.cornerRadius = 10
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
        view.showCurrentTime = true
        return view
    }()
    
    private func setupViews() {
     
        timeWheel.addSubview(timePicker)
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        timePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
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
        print(currentTime)
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
       
        
        let timeText = [formattedHour, minute].compactMap {
            String(format: "%02d", $0)
        }.joined(separator: ":")
        
        let timw = "\(formattedHour)" + ":" + String(format: "%02d", formattedMin)
        timeStr = String(timw) + " " + hourFormat.rawValue
        let bool:Bool = viewModel.addRemaiderTime(timeStr: timeStr)
        if bool == true{
            
            self.addReminderButton.setTitle(("A " + timeStr + " Reminder Is Set Already"), for: .normal)
            self.addReminderButton.titleLabel?.font = UIFont.semiBold(ofSize: 17)
            self.addReminderButton.backgroundColor =  AnthemColor.buttonDisableColor
            self.addReminderButton.isUserInteractionEnabled =  false

        }else{
            let selectedRemindertime = "Add \(timw) \(hourFormat.rawValue) Reminder"
            self.addReminderButton.titleLabel?.font = UIFont.semiBold(ofSize: 17)
            self.addReminderButton.setTitle(selectedRemindertime, for: .normal)
            addReminderButton.backgroundColor =  AnthemColor.colonLabelColor
            self.addReminderButton.isUserInteractionEnabled =  true



        }

    }
    func addBoldText(fullString: NSString, boldPartsOfString: [String], font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
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
}

