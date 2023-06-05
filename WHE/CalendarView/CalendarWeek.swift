//
//  CalendarWeek.swift
//  WHE
//
//  Created by Pratima Pundalik on 17/01/23.
//

import UIKit
var totalWeekDates = [Date]()
var selectedDate = Date()

class CalendarWeek: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setWeekView()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWeekView(){
        totalWeekDates.removeAll()
        
        var currentMonday = CalendarHelper().mondayForDate(date: selectedDate)
        
        let nextMonday = CalendarHelper().addDays(date: currentMonday, days: 7)
        
        
        while (currentMonday < nextMonday)
        {
            totalWeekDates.append(currentMonday)
            currentMonday = CalendarHelper().addDays(date: currentMonday, days: 1)
        }
        
        let monthLabeltext = CalendarHelper().monthString(date: selectedDate)
        + " " + CalendarHelper().yearString(date: selectedDate)
    }
    
    func getdatesOfCurrentWeek(day:Int) -> String{
        let date = totalWeekDates[day]
        let dateText = String(CalendarHelper().dayOfMonth(date: date))
        return dateText
    }
    
    func setup() {
        let currentWeek = UIStackView()
        //   stack.isUserInteractionEnabled = true
        currentWeek.axis = .horizontal
        currentWeek.distribution = .fillEqually
        currentWeek.spacing = 10
        //currentWeek.spacing = 18
        let monday = CalendarDay()
        monday.daylabel.text = "M"
        monday.circularLabel.text = getdatesOfCurrentWeek(day: 0)
        updateDateTextColor(day: 0, calendarDay: monday)
        monday.translatesAutoresizingMaskIntoConstraints = false
        currentWeek.addArrangedSubview(monday)
        updateBackgroundColor(calendarDay: monday)
        
        let tuesday = CalendarDay()
        tuesday.daylabel.text = "T"
        tuesday.circularLabel.text = getdatesOfCurrentWeek(day: 1)
        updateDateTextColor(day: 1, calendarDay: tuesday)
        tuesday.translatesAutoresizingMaskIntoConstraints = false
        currentWeek.addArrangedSubview(tuesday)
        updateBackgroundColor(calendarDay: tuesday)
        
        let wednesday = CalendarDay()
        wednesday.daylabel.text = "W"
        wednesday.circularLabel.text = getdatesOfCurrentWeek(day: 2)
        updateDateTextColor(day: 2, calendarDay: wednesday)
        wednesday.translatesAutoresizingMaskIntoConstraints = false
        
        currentWeek.addArrangedSubview(wednesday)
        updateBackgroundColor(calendarDay: wednesday)
        
        let thursday = CalendarDay()
        thursday.daylabel.text = "T"
        thursday.circularLabel.text = getdatesOfCurrentWeek(day: 3)
        updateDateTextColor(day: 3, calendarDay: thursday)
        thursday.translatesAutoresizingMaskIntoConstraints = false
        currentWeek.addArrangedSubview(thursday)
        updateBackgroundColor(calendarDay: thursday)
        
        let friday = CalendarDay()
        friday.daylabel.text = "F"
        friday.circularLabel.text = getdatesOfCurrentWeek(day: 4)
        updateDateTextColor(day: 4, calendarDay: friday)
        friday.translatesAutoresizingMaskIntoConstraints = false
        currentWeek.addArrangedSubview(friday)
        updateBackgroundColor(calendarDay: friday)
        
        let saturday = CalendarDay()
        saturday.daylabel.text = "S"
        saturday.circularLabel.text = getdatesOfCurrentWeek(day: 5)
        updateDateTextColor(day: 5, calendarDay: saturday)
        saturday.translatesAutoresizingMaskIntoConstraints = false
        currentWeek.addArrangedSubview(saturday)
        updateBackgroundColor(calendarDay: saturday)
        
        let sunday = CalendarDay()
        sunday.daylabel.text = "S"
        sunday.circularLabel.text = getdatesOfCurrentWeek(day: 6)
        updateDateTextColor(day: 6, calendarDay: sunday)
        sunday.translatesAutoresizingMaskIntoConstraints = false
        currentWeek.addArrangedSubview(sunday)
        updateBackgroundColor(calendarDay: sunday)
        
        self.addSubview(currentWeek)
        currentWeek.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentWeek.topAnchor.constraint(equalTo: self.topAnchor, constant: 41),
            currentWeek.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 11),
            currentWeek.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            currentWeek.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
        ])
    }
    
    func updateBackgroundColor(calendarDay: CalendarDay) {
        
        let currentDate = String(CalendarHelper().dayOfMonth(date: selectedDate))
        let calendarDayText = calendarDay.circularLabel.text
        if currentDate == calendarDayText {
            calendarDay.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
            calendarDay.layer.cornerRadius = 10
            calendarDay.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            calendarDay.daylabel.textColor = UIColor(red: 0.31, green: 0.04, blue: 0.71, alpha: 1.00)
            calendarDay.daylabel.font = UIFont.semiBold(ofSize: 15)
            calendarDay.circularLabel.textColor = AnthemColor.highLightedDateTextColor
            calendarDay.circularLabel.layer.borderColor = AnthemColor.HighlightedCircleBorderColor.cgColor
            calendarDay.layer.borderColor = AnthemColor.medicationSelectedViewBGColor.cgColor
            calendarDay.dropShadowWithCornerRaduis()
            calendarDay.layer.shadowColor = UIColor.black.cgColor
            calendarDay.layer.shadowOpacity = 1
            calendarDay.layer.shadowOffset = .zero
            calendarDay.layer.shadowRadius = 10
            calendarDay.clipsToBounds = true
            calendarDay.addBorders(to: [.top,.left,.right], in: AnthemColor.medicationSelectedViewBGColor, width: 1)
            calendarDay.addBorders(to: [.bottom], in: UIColor.white, width: 1)
        } else {
            calendarDay.backgroundColor = UIColor.clear
        }
    }
    
    func updateDateTextColor(day:Int, calendarDay: CalendarDay) {
        let providedDate = totalWeekDates[day]
        let weekDate = CalendarHelper().dayOfMonth(date: providedDate)
        let currentDate = CalendarHelper().dayOfMonth(date: selectedDate)
        if (weekDate > currentDate) {
            calendarDay.circularLabel.textColor = AnthemColor.DayTextColor
        } else {
            calendarDay.circularLabel.textColor = AnthemColor.enabledDateTextColor
        }
    }
  
}



