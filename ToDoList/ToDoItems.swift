//
//  ToDoItems.swift
//  ToDoList
//
//  Created by John Linnehan on 10/4/21.
//

import Foundation
import UserNotifications

class ToDoItems {
    var itemsArray: [ToDoItem] = []
    
    func saveData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
        
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(itemsArray)
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("Could not save data")
        }
        setNotifications()
    }
    
    
    func loadData(completed: @escaping ()->()) {
            let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
    
            guard let data = try? Data(contentsOf: documentURL) else {return}
            let jsonDecoder = JSONDecoder()
            do {
                itemsArray = try jsonDecoder.decode(Array<ToDoItem>.self, from: data)
            } catch {
                print("Could not load data")
            }
            completed()
    }
    
    func setNotifications() {
        guard itemsArray.count > 0 else {
            return
        }
        //remove notifications
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        //recreate with the saved data
        for index in 0..<itemsArray.count {
            if itemsArray[index].reminderSet {
                let toDoItem = itemsArray[index]
                itemsArray[index].notificationID = LocalNotificaitonManager.setCalendarNotification(title: toDoItem.name, subtitle: "", body: toDoItem.notes, badgeNumber: nil, sound: .default, date: toDoItem.date)
            }
        }
    }
}
