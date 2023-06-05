//
//  TimePickerView.swift
//  WHE
//
//  Created by Pratima Pundalik on 20/02/23.
//

import UIKit

public enum HourFormat: String, CaseIterable {
    case am = "AM"
    case pm = "PM"
}

public var onDefaultTimePicked: ((_ hour: Int, _ minute: Int, _ hourFormat: HourFormat) -> Void)?

let date = Date()
var calendar = Calendar.current

let currentHour = calendar.component(.hour, from: date)
let currentMinute = calendar.component(.minute, from: date)


open class RealTimePickerView: UIView {
    private enum Constants {
        static let fontSize: CGFloat = 44
        static let colonFontSize: CGFloat = Constants.fontSize * 0.75
        static let formatFontSize: CGFloat = 24
    }
    
    public enum TimeFormat: String {
        case h12
        var hours: [Int] {
            switch self {
            case .h12:
                return Array(1...12)
            }
        }
        
        var components: [TimeComponent] {
            switch self {
            case .h12:
                return [.hour, .minute, .format]
            }
        }
    }
    
    public enum TimeComponent: Int, CaseIterable {
        case hour = 0
        case minute = 1
        case format = 2
    }
    public var showDefaultDailyCheckinTime: Bool = false
    // MARK: - Public properties
    
    /// The default value in picker view with current time
    public var showCurrentTime: Bool = false {
        didSet {
            if showCurrentTime {
                updateDateTime(Date())
            }
        }
    }
   
    public var formattedDefaultMin: Int?
    public var formattedDefaultHour: Int?
    public var defaultHourFormat: HourFormat = .am

    /// The default height in points of each row in the picker view.
    public var rowHeight: CGFloat = 58.0
    /// The default label font of each time row component in the picker view.
    public var timeLabelFont: UIFont?
    /// The default label font of format (AM/PM) component in the picker view.
    public var formatLabelFont: UIFont?
    /// The default font of colon between picker components
    public var colonLabelFont: UIFont? {
        didSet {
            colonLabel.font = colonLabelFont
        }
    }
    // The default static ":" indicator between columns.
    public var showUnitSeparator = true {
        didSet {
            colonLabel.isHidden = !showUnitSeparator
        }
    }
    
    /// Callback for pickerView(didSelectRow:) method in (hour: Int, minute: Int) format
    public var onNumberTimePicked: ((_ hour: Int, _ minute: Int, _ hourFormat: HourFormat) -> Void)?
    
    
    // MARK: - Private properties
    private var timeFormat: TimeFormat
    private var components: [TimeComponent]
    private var hours: [Int]
    private var minutes: [Int] = Array(0..<60).filter { $0 % 15 == 0}
    private var hourFormats: [HourFormat] = HourFormat.allCases
    private var selectedHour: Int?
    private var selectedMinute: Int?
    private var selectedHourFormat: HourFormat?
    private var hourRows: Int = 10_000
    private lazy var hourRowsMiddle: Int = ((hourRows / hours.count) / 2) * hours.count
    
    private var minuteRows: Int = 10_000
    private lazy var minuteRowsMiddle: Int = ((minuteRows / minutes.count) / 2) * minutes.count
    
    // MARK: - Views
    public var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private lazy var colonLabel: UILabel = {
        let label = UILabel()
        let size = Constants.colonFontSize
        label.frame.size = CGSize(width: 6, height: 30)
        label.font = UIFont.systemFont(ofSize: size, weight: .bold)
        label.textColor = AnthemColor.colonLabelColor
        label.text = ":"
        return label
    }()
    
    private var leftConstraintAnchor: NSLayoutConstraint?
    
    public init(format: TimeFormat = .h12, tintColor: UIColor = .clear) {
        self.timeFormat = format
        self.components = format.components
        self.hours = format.hours
        super.init(frame: .zero)
        self.tintColor = tintColor
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        nil
    }
    
    public func update(timeFormat: TimeFormat) {
        self.timeFormat = timeFormat
        self.components = timeFormat.components
        self.hours = timeFormat.hours
        pickerView.reloadAllComponents()
        layoutSubviews()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        guard !components.isEmpty else { return }
        let offset = (frame.width / CGFloat(components.count)) - 2
        leftConstraintAnchor?.constant = offset
        leftConstraintAnchor?.isActive = true
    }
    
    open func setupViews() {
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        pickerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        pickerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        pickerView.addSubview(colonLabel)
        colonLabel.translatesAutoresizingMaskIntoConstraints = false
        colonLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        leftConstraintAnchor = colonLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func showDefaultTime(currentMinute: Int) -> Int {
        var defaultMinute = 0
        switch currentMinute {
        case 0...7:
            defaultMinute = 00
        case 8...23:
            defaultMinute = 15
        case 24...37:
            defaultMinute = 30
        case 38...53:
            defaultMinute = 45
        case 54...60:
            defaultMinute = 60
        default:
            break
        }
        return defaultMinute
    }
        
    func showDefaultHour(defaultmin: Int) -> Int? {
        let defaultMin = showDefaultTime(currentMinute: defaultmin)
        var currentHour = currentHour
        if (defaultMin == 0){
            return currentHour
        }
        if (defaultMin > 0 && defaultMin % 60 == 0) {
            currentHour = currentHour + 1
            return currentHour
        } else {
            return currentHour
        }
    }
    
    open func updateDateTime(_ date: Date) {
        let currentTime = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        var defaultHour : Int?
        var defaultMin: Int
        
         if showDefaultDailyCheckinTime  {
            defaultHour = 19
            defaultMin = 0
        } else {
            defaultHour = showDefaultHour(defaultmin: currentMinute) ?? 1
            defaultMin = showDefaultTime(currentMinute: currentMinute)
        }
        let updatedMinute = defaultMin == 60 ? defaultMin % 60 : defaultMin
        
        if var hour = defaultHour, components.count > TimeComponent.hour.rawValue {
            if timeFormat == .h12 {
                selectedHourFormat = hour < 12 ? .am : .pm
                /// 0:00 / midnight to 0:59 add 12 hours and AM to the time:
                if hour == 0 {
                    selectedHourFormat = .am
                    hour += 12
                }
                /// From 1:00 to 11:59, simply add AM to the time:
                if hour >= 1 && hour <= 11 {
                    selectedHourFormat = .am
                }
                /// For times between 13:00 to 23:59, subtract 12 hours and add PM to the time:
                if hour >= 13 && hour <= 23 {
                    hour -= 12
                    selectedHourFormat = .pm
                }
            }
            let neededRowIndex = hourRowsMiddle + hour
            
            self.selectedHour = hour
            switch selectedHourFormat {
            case .am:
                pickerView.selectRow(0, inComponent: TimeComponent.format.rawValue, animated: true)
            case .pm:
                pickerView.selectRow(1, inComponent: TimeComponent.format.rawValue, animated: true)
                
            default:
                break
            }
            
            self.formattedDefaultHour = hour
            self.formattedDefaultMin = updatedMinute
            
            self.defaultHourFormat = selectedHourFormat ?? .am
            
            switch timeFormat {
            case .h12 where hours.first == 1:
                pickerView.selectRow(neededRowIndex - 1, inComponent: TimeComponent.hour.rawValue, animated: true)
                
            default:
                break
            }
        }
 
        if let minute = currentTime.minute, components.count > TimeComponent.minute.rawValue {
            let neededRowIndex = updatedMinute / 15
            let nededRowIndex = minuteRowsMiddle + neededRowIndex
            
            self.selectedMinute = minute
            pickerView.selectRow(nededRowIndex, inComponent: TimeComponent.minute.rawValue, animated: true)
            highLightSelectedTime(row: neededRowIndex, component: TimeComponent.minute.rawValue)
        }
    }
}

extension RealTimePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return components.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch components[component] {
        case .hour:
            return hourRows
        case .minute:
            return minuteRows
        case .format:
            return hourFormats.count
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AnthemColor.timelabelcolor
        label.frame.size = CGSize(width: 50, height: 38)
        label.font = timeLabelFont
        switch components[component]  {
        case .hour:
            label.text = String(hours[row % hours.count])
            
            
        case .minute:
            label.text = String(format: "%02d", minutes[row % minutes.count])
            
            
        case .format:
            label.font = formatLabelFont ?? UIFont.systemFont(ofSize: Constants.formatFontSize, weight: .bold)
            label.text = hourFormats[row].rawValue
            
        }
        label.backgroundColor = UIColor.clear
        highLightSelectedTime(row: row, component: component)
        return label
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return rowHeight
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch components[component] {
        case .hour:
            self.selectedHour = hours[safe: row % hours.count]
        case .minute:
            self.selectedMinute = minutes[safe: row % minutes.count]
        case .format:
            self.selectedHourFormat = hourFormats[safe: row]
        }
        
        guard var hour = selectedHour, let minute = selectedMinute, let hourFormat = selectedHourFormat else { return }
        
        var calendar = Calendar.current
        calendar.timeZone = .current
        switch selectedHourFormat {
        case .pm where hour >= 1 && hour <= 11:
            hour += 12
        case .am where hour == 12:
            hour = 12
        default:
            break
        }
        guard let date = calendar.date(bySettingHour: hour, minute: minute, second: 0, of:  Date()) else {
            return
        }
        
        if (((minute ?? 0)  % 15) == 0) {
            onNumberTimePicked?(hour, minute, hourFormat)
        } else {
            var defaultMin: Int
            if showDefaultDailyCheckinTime {
                defaultMin = 0
                onNumberTimePicked?(hour, defaultMin, hourFormat)
            } else {
                defaultMin = showDefaultTime(currentMinute: minute)
                onNumberTimePicked?(hour, defaultMin, hourFormat)
            }
        }
        
        highLightSelectedTime(row: row, component: component)
    }
    
    func highLightSelectedTime(row:Int, component: Int){
        let selectedTime =  self.pickerView.view(forRow: row, forComponent: component)
        if let selectedTimelabel = selectedTime as? UILabel {
            selectedTimelabel.backgroundColor = AnthemColor.tabBarPalePurple
            selectedTimelabel.textColor = AnthemColor.highLightedDateTextColor
        } else if let view = selectedTime as? UIView {
            view.backgroundColor = AnthemColor.tabBarPalePurple
        }
    }
}
