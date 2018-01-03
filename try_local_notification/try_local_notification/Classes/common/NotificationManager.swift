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
               timeInterval: (time: Int, type: TimeIntervalType),
               idetifer: String) {
    
    // If current notification status is denied or not determined, ask for turning on
    askAuthorizationIfNeeded(currentViewController)
    
    // Get notification contents
    let content = getNotificationContent(title: title,
                                         subTitle: subTitle,
                                         body: body,
                                         imageName: attachedImage?.name,
                                         imageExtension: attachedImage?.ext)
    
    // Configure the trigger for 10 sec later.
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    
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
  
  private func getNotificationContent(title: String,
                                      subTitle: String? = nil,
                                      body: String,
                                      imageName: String? = nil,
                                      imageExtension: String? = nil) -> UNMutableNotificationContent {
    // Create notification contents
    let content = UNMutableNotificationContent()
    content.title = title
    if let subTitle = subTitle {
      content.subtitle = subTitle
    }
    content.body = body
    
    // Attached Image
    if let url = Bundle.main.url(forResource: imageName, withExtension: imageExtension) {
      let attachment = try? UNNotificationAttachment(identifier: "attachment", url: url, options: nil)
      if let attachment = attachment {
        content.attachments = [attachment]
      }
    }
    return content
  }
  
  func cancel(identifers: [String]) {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: identifers)
  }
}

// MARK: - Authorization

extension NotificationManager {
  
  func askAuthorizationIfNeeded(_ currentViewContoller: UIViewController) {
    getAuthorizationStatus({ (status) in
      if status ==  .authorized {
        print("NotificationManager: askAuthorizationIfNeeded: Authorized")
      } else if status == .denied {
        print("NotificationManager: askAuthorizationIfNeeded: Denied")
        self.askAuthorization(currentViewContoller)
      } else {
        print("NotificationManager: askAuthorizationIfNeeded: NotDetermined")
        self.requestAuthorization()
      }
    })
  }
  
  private func askAuthorization(_ currentViewContoller: UIViewController) {
    let alert = UIAlertController(
      title: "Turn on Notificaton",
      message: "For usage of this function, notification settings should be turned on",
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(title: "No", style: .cancel) {action in})
    alert.addAction(UIAlertAction(title: "Turn on", style: .default) {action in
      self.openNotificationSettings()
    })
    currentViewContoller.present(alert, animated: true, completion: nil)
  }
  
  private func openNotificationSettings() {
    guard let settingsUrl = URL(string:UIApplicationOpenSettingsURLString) else { return }
    UIApplication.shared.open(settingsUrl)
  }
  
  private func getAuthorizationStatus(_ result: @escaping (UNAuthorizationStatus)->()) {
    UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings: UNNotificationSettings) in
      result(settings.authorizationStatus)
    })
  }
  
  private func requestAuthorization() {
    UNUserNotificationCenter.current().requestAuthorization(
      options: [.badge, .sound, .alert],
      completionHandler: { (granted, error) in
        if error != nil { return }
        granted ?
          print("NotificationManager: requestAuthorization: Authorized") :
          print("NotificationManager: requestAuthorization: Denied")
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
