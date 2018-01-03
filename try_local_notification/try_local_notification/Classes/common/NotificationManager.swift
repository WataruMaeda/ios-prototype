//
//  NotificationManager.swift
//  try_local_notification
//
//  Created by Wataru Maeda on 2017/12/31.
//  Copyright © 2017 com.watarumaeda. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationManager: NSObject {
  
  static var shared = NotificationManager()
  override private init() {} // Singleton
  
  lazy var content = UNMutableNotificationContent()
  
  func scedule(idetifer: String) {
    content.title = NSString.localizedUserNotificationString(forKey: "Wake up!", arguments: nil)
    content.body = NSString.localizedUserNotificationString(forKey: "Rise and shine! It's morning time!", arguments: nil)
    
    // Configure the trigger for 10 sec later.
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
    
    // Create the request object.
    let request = UNNotificationRequest(identifier: idetifer, content: content, trigger: trigger)
    
    // Schedule the request.
    let center = UNUserNotificationCenter.current()
    center.add(request) { (error : Error?) in
      if let theError = error {
        print(theError.localizedDescription)
      }
    }
  }
  
  func cancel(identifers: [String]) {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: identifers)
  }
}

// MARK: - Setup

extension NotificationManager {
  
  func setup() {
    UNUserNotificationCenter.current().delegate = self
    requestAuth()
  }
  
  private func requestAuth() {
    if #available(iOS 10.0, *) {
      // iOS 10
      UNUserNotificationCenter.current().requestAuthorization(
        options: [.badge, .sound, .alert],
        completionHandler: { (granted, error) in
          if error != nil { return }
          granted ? debugPrint("通知許可") : debugPrint("通知拒否")
      })
      
    } else {
      // iOS 9
      let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
      UIApplication.shared.registerUserNotificationSettings(settings)
    }
  }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
  
  // If app is foreground
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    // Update the app interface directly.
    
    // Play a sound.
    completionHandler(UNNotificationPresentationOptions.sound)
  }
}
