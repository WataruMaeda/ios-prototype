//
//  Helper.swift
//  try_ocr
//
//  Created by Wataru Maeda on 2018-05-20.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

// MARK: - UIVew+Ext

extension UIView {
  
  var viewWidth: CGFloat {
    return frame.size.width
  }
  
  var viewHeight: CGFloat {
    return frame.size.height
  }
}

// MARK: - UIButton+Ext

extension UIButton {
  
  static func generateButton(title: String, frame: CGRect, callback: @escaping () -> Void) -> UIButtonCallback {
    let button = UIButtonCallback()
    button.frame = frame
    button.setTitle(title, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
    button.setTitleColor(.darkGray, for: .normal)
    button.handleTap(event: .touchUpInside) { _ in
      callback()
    }
    return button
  }
}

// MARK: - UIImage+Ext

extension UIImage {
  
  static func convertToImage(view: UIView) -> UIImage? {
    UIGraphicsBeginImageContext(view.frame.size)
    view.layer.render(in: UIGraphicsGetCurrentContext()!)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img
  }
}

// MARK: - UIAlert+Ext

extension UIAlertController {
  
  static func show(_ viewController:  UIViewController, title: String) {
    let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
    viewController.present(alert, animated: true, completion: nil)
  }
}

// MARK: - Callback Button

class UIButtonCallback: UIButton {
  
  private lazy var callback: (UIButton)->Void = { button in }
  
  func handleTap(event: UIControlEvents, callback: @escaping (UIButton)->Void) {
    self.callback = callback
    addTarget(self, action: #selector(tapped), for: event)
  }
  
  @objc private func tapped() {
    callback(self)
  }
}
