//
//  LocalNotificationManager.swift
//  ToDoList
//
//  Created by John Linnehan on 10/4/21.
//

import UIKit
import UserNotifications

struct LocalNotificaitonManager {
    static func authorizeLocalNotification(viewController: UIViewController) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard error == nil else {
                print("Error \(error!.localizedDescription)")
                return
            }
            if granted {
                print("Granted")
            } else {
                print("denied notification")
                DispatchQueue.main.async {
                    viewController.oneButtonAlert(title: "User Has Not Allowed Notifications", message: "To receive alerts for reminders, open the settings app, select ToDoList > Notifications > Allow Notifications")
                }
                
            }
        }
    }
    
    static func isAuthorized(completed: @escaping (Bool)->()) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard error == nil else {
                print("Error \(error!.localizedDescription)")
                completed(false)
                return
            }
            if granted {
                print("Granted")
                completed(true)
            } else {
                print("denied notification")
                completed(false)
                }
                
            }
        }
    }
    
func setCalendarNotification(title: String, subtitle: String, body: String, badgeNumber: NSNumber?, sound: UNNotificationSound?, date: Date) -> String {
        //create content
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = sound
        content.badge = badgeNumber
        
        //create trigger
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponents.second = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //create request
        let notificationID = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
        
        //register a request with the notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error")
            } else {
                print("notificaiton scheduled")
            }
        }
        return notificationID
    }
}
