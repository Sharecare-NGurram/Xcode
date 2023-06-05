//
//  Task.swift
//  WHE
//
//  Created by Pratima Pundalik on 06/02/23.
//

import Foundation


struct Task: Identifiable, Codable {
  var id = UUID().uuidString
  var name: String
  var completed = false
  var reminderEnabled = false
  var reminder: Reminder
}

struct Reminder: Codable {
  var timeInterval: TimeInterval?
  var date: Date?
  var reminderType: ReminderType = .time
}

enum ReminderType: Int, CaseIterable, Identifiable, Codable {
  case time
  case calendar
  var id: Int { self.rawValue }
}

