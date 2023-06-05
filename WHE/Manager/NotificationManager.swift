//
//  NotificationManager.swift
//  WHE
//
//  Created by Pratima Pundalik on 06/02/23.
//

import Foundation
import NotificationCenter

class NotificationManager {
    static let shared = NotificationManager()
    let notificationCenter = UNUserNotificationCenter.current()
    private init(){}
    
    func requestForNotification() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { permissionGranted, error in
            if permissionGranted {
                print("permission granted")
                self.fetchNotificationSettings()
            } else {
                print("error occured ")
            }
        }
    }
    
    func fetchNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            if (settings.authorizationStatus == .authorized){
              //  self.registerNotification()
            } else {
                //go to setting screen to provide permision
                
            }
        }
    }
    
    func enableNotificationSettings(){
        let alertController = UIAlertController(title: "Enable notificaiond?", message: "To use this feature you must enable notifications in settings ", preferredStyle: .alert)
        let goToSettings = UIAlertAction(title: "Settings", style: .default) { (_) in
            guard let settingUrl = URL(string: UIApplication.openSettingsURLString) else{
                return
            }
            if (UIApplication.shared.canOpenURL(settingUrl)){
                UIApplication.shared.open(settingUrl){ (_) in }
            }
            
        }
        alertController.addAction(goToSettings)
        alertController.addAction(UIAlertAction(title: "cancel", style: .default, handler: { (_) in
        }))
        alertController.present(alertController, animated: true)
    }
    
    func removeScheduledNotification(task: Task) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [task.id])
    }
    
    func getNotifiContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = NotificationContent.title
        content.body = NotificationContent.body
        content.sound = .default
        content.categoryIdentifier = "ClearNotifCategory"
        return content
    }
    
    func registerNotification(hour:Int, min: Int) {
        let clearAction = UNNotificationAction(identifier: "ClearNotif", title: "Clear", options: [])
        let category = UNNotificationCategory(identifier: "ClearNotifCategory", actions: [clearAction], intentIdentifiers: [], options: .customDismissAction)
        notificationCenter.setNotificationCategories([category])
        
        let content = self.getNotifiContent()
        var dateComponents = DateComponents()

        dateComponents.hour = hour
        dateComponents.minute = min
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "1008", content: content, trigger: trigger)
        notificationCenter.add(request){ (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
}
