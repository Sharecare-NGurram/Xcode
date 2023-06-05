//
//  CalendarDay.swift
//  WHE
//
//  Created by Pratima Pundalik on 17/01/23.
//

import UIKit
class CalendarDay: UIView {
    let daylabel = UILabel()
    let circularLabel = CircleLabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let size:CGFloat = 45.0
        setupDayLabel(dayLabel: daylabel)
        let emptySpace = UILabel()
        
        let calendarDayStack = UIStackView()
        calendarDayStack.axis = .vertical
        calendarDayStack.distribution = .fillProportionally
        calendarDayStack.alignment = .center
        calendarDayStack.addArrangedSubview(daylabel)
        calendarDayStack.addArrangedSubview(circularLabel)
        calendarDayStack.addArrangedSubview(emptySpace)
        self.addSubview(calendarDayStack)
        calendarDayStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarDayStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            calendarDayStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            calendarDayStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            calendarDayStack.heightAnchor.constraint(equalToConstant: size*2 + 3),
            calendarDayStack.widthAnchor.constraint(equalToConstant: size + 8)
        ])
        
        
    }
    
    override var intrinsicContentSize: CGSize {
        //preferred content size, calculate it if some internal state changes
        return CGSize(width: 70, height: 75)
    }
    
    func setupDayLabel(dayLabel: UILabel) {
        dayLabel.font = UIFont.mediumBold(ofSize: 15)
        dayLabel.textColor = AnthemColor.DayTextColor
    }
    
    func getCurrentWeek(){
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        let dayOfWeek = calendar.component(.weekday, from: today)
        let days = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today) }
            .filter { !calendar.isDateInWeekend($0) }
    }
    
}
