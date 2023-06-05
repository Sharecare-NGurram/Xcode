//
//  ReminderManger.swift
//  WHE
//
//  Created by Pratima Pundalik on 07/02/23.
//

import Foundation
class ReminderManger {
    var tasks: [Task] = []
    let timeDurations: [Int] = Array(1...59)
    static let shared = ReminderManger()
    let taskPersistenceManager = TaskPersistenceManager()
    
    func createReminder() -> Reminder? {
        var reminder = Reminder()
        reminder.timeInterval = TimeInterval(timeDurations[0] * 60)
        return reminder
    }
    
    func addNewReminder(_ medicineName: String, _ reminder: Reminder?)  {
        if let reminder = reminder {
            //save reminder
            saveReminder(task: Task(name: medicineName, reminder: reminder))
        }
    }
    
    func saveReminder(task: Task)  {
        tasks.append(task)
        DispatchQueue.global().async {
            self.taskPersistenceManager.save(tasks: self.tasks)
        }
        if task.reminderEnabled {
           // NotificationManager.shared.registerNotification()
        }
        
    }
    func deleteReminder(task: Task)  {
        NotificationManager.shared.removeScheduledNotification(task: task)
    }
}
