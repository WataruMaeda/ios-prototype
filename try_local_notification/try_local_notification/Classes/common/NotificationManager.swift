//
//  NotificationManager.swift
//  try_local_notification
//
//  Created by Wataru Maeda on 2017/12/31.
//  Copyright © 2017 com.watarumaeda. All rights reserved.
//

import UIKit
import UserNotifications

enum TimeIntervalType {
  case sec, min, hour, day, week, month
}

class NotificationManager: NSObject {
  
  static var shared = NotificationManager()
  override private init() {} // Singleton
  
  func setup() {
    UNUserNotificationCenter.current().delegate = self
  }
  
  func scedule(_ currentViewController: UIViewController,
               title: String,
               subTitle: String? = nil,
               body: String,
               attachedImage: (name: String, ext: String)? = nil,
               timeInterval: (time: Int, type: TimeIntervalType, repeats: Bool),
               notificationIdentifer: String) {
    
    // Get current Authorization status
    getAuthorizationStatus { (status) in
      if status == .authorized {
        // Schedule notification
        self.sceduleNotifiation(currentViewController,
                           title: title,
                           body: body,
                           attachedImage: attachedImage,
                           timeInterval: timeInterval,
                           notificationIdentifer: notificationIdentifer)
      } else if status == .denied {
        // Open notification setting screen
        self.requestAuthorizationWithAlert(currentViewController)
      } else if status == .notDetermined {
        // Request Authorization
        self.requestAuthorization({ (granted) in
          if granted {
            // Schedule notification
            self.sceduleNotifiation(currentViewController,
                                    title: title,
                                    body: body,
                                    attachedImage: attachedImage,
                                    timeInterval: timeInterval,
                                    notificationIdentifer: notificationIdentifer)
          } else {
            // Denied alert
            self.requestDeniedAlert(currentViewController)
          }
        })
      }
    }
  }
  
  func cancel(identifers: [String]) {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: identifers)
  }
}

// MARK: - Notification Contents

extension NotificationManager {
  
  fileprivate func sceduleNotifiation(_ currentViewController: UIViewController,
                                      title: String,
                                      subTitle: String? = nil,
                                      body: String,
                                      attachedImage: (name: String, ext: String)? = nil,
                                      timeInterval: (time: Int, type: TimeIntervalType, repeats: Bool),
                                      notificationIdentifer: String) {
    
    // Configure notification contents
    getNotificationContent(
      title: title,
      subTitle: subTitle,
      body: body,
      imageName: attachedImage?.name,
      imageExtension: attachedImage?.ext) { (content) in
        
        // Configure the trigger
        let trigger = self.getTrigger(timeInterval: timeInterval.time,
                                 type: timeInterval.type,
                                 repeats: timeInterval.repeats)
        
        // Create the request object
        let request = UNNotificationRequest(identifier: notificationIdentifer,
                                            content: content,
                                            trigger: trigger)
        
        // Schedule the request
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
          if let theError = error {
            print(theError.localizedDescription)
          }
        }
    }
  }
  
  private func getNotificationContent(title: String,
                                          subTitle: String? = nil,
                                          body: String,
                                          imageName: String? = nil,
                                          imageExtension: String? = nil,
                                          callback: @escaping (UNMutableNotificationContent) -> ()) {
    // Current badge number
    getCurrentBadgeNumber { (currentBadgeNum) in
      
      // Create notification contents
      let content = UNMutableNotificationContent()
      content.title = title
      if let subTitle = subTitle {
        content.subtitle = subTitle
      }
      content.body = body
      content.badge = (currentBadgeNum + 1 as NSNumber)
      
      // Attached Image
      if let url = Bundle.main.url(forResource: imageName, withExtension: imageExtension) {
        let attachment = try? UNNotificationAttachment(identifier: "attachment", url: url, options: nil)
        if let attachment = attachment {
          content.attachments = [attachment]
        }
      }
      callback(content)
    }
  }
  
  private func getTrigger(timeInterval: Int,
                              type: TimeIntervalType,
                              repeats: Bool) -> UNTimeIntervalNotificationTrigger {
    
    // Actual timer itnerval by second
    var timeIntervalBySec = timeInterval
    
    // Convert timer interval to secound
    switch type {
    case .min:
      timeIntervalBySec = timeInterval * 60
    case .hour:
      timeIntervalBySec = timeInterval * 60 * 60
    case .day:
      timeIntervalBySec = timeInterval * 60 * 60 * 24
    case .week:
      timeIntervalBySec = timeInterval * 60 * 60 * 24 * 7
    case .month:
      timeIntervalBySec = timeInterval * 60 * 60 * 24 * 7 * 30
    default:
      break
    }
    
    return UNTimeIntervalNotificationTrigger(
      timeInterval: TimeInterval(timeIntervalBySec),
      repeats: repeats)
  }
}

// MARK: - Authorization

extension NotificationManager {
  
  fileprivate func getAuthorizationStatus(_ result: @escaping (UNAuthorizationStatus)->()) {
    UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings: UNNotificationSettings) in
      result(settings.authorizationStatus)
    })
  }
  
  fileprivate func requestAuthorizationWithAlert(_ currentViewContoller: UIViewController) {
    let alert = UIAlertController(
      title: "Turn on Notificaton",
      message: "For usage of the function, notification settings should be turned on",
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(title: "No", style: .cancel) {action in})
    alert.addAction(UIAlertAction(title: "Turn on", style: .default) {action in
      self.openNotificationSettings()
    })
    currentViewContoller.present(alert, animated: true, completion: nil)
  }
  
  fileprivate func requestDeniedAlert(_ currentViewContoller: UIViewController) {
    let alert = UIAlertController(
      title: "Authorization was denied",
      message: "For usage of the sceduling function, please update notification setting",
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(title: "OK", style: .cancel) {action in})
    currentViewContoller.present(alert, animated: true, completion: nil)
  }
  
  fileprivate func openNotificationSettings() {
    guard let settingsUrl = URL(string:UIApplicationOpenSettingsURLString) else { return }
    UIApplication.shared.open(settingsUrl)
  }
  
  private func requestAuthorization(_ callback: @escaping (Bool)->()) {
    UNUserNotificationCenter.current().requestAuthorization(
      options: [.badge, .sound, .alert],
      completionHandler: { (granted, error) in
        if error != nil { return }
        granted ? callback(true) : callback(false)
    })
  }
}

// MARK: UNUserNotificationCenterDelegate

extension NotificationManager: UNUserNotificationCenterDelegate {
  
  // If app is foreground
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    print("NotificationManager: userNotificationCenter: \(notification)")
    // Update the app interface directly.
    // Play a sound.
    completionHandler(UNNotificationPresentationOptions.sound)
  }
}

// MARK: Supporting Functions

extension NotificationManager {
  
  fileprivate func getCurrentBadgeNumber(_ callback: @escaping (Int)->()) {
    DispatchQueue.main.async(execute: {
      callback(UIApplication.shared.applicationIconBadgeNumber)
    })
  }
}
