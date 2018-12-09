//
//  AlertUtil.swift
//  Copyright © 2018 wataru maeda. All rights reserved.
//

import UIKit

class AlertUtil: NSObject {
  
  static func show(title: String, message: String) {
    guard let viewController = UIViewController.topViewController else { return }
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "OK", style: .cancel) {action in}
    alert.addAction(cancelAction)
    viewController.present(alert, animated: true, completion: nil)
  }
}
