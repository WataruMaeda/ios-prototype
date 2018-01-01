//
//  Button+Helper.swift
//  try_local_notification
//
//  Created by Wataru Maeda on 2017/12/31.
//  Copyright © 2017 com.watarumaeda. All rights reserved.
//

import UIKit

// MARK: - UI

extension UIButton {
  
  func setupButton() {
    setImage(#imageLiteral(resourceName: "btn-alert"), for: .normal)
    imageView?.contentMode = .scaleAspectFit
    imageView?.backgroundColor = .clear
    clipsToBounds = false
  }
}

class UICallbackButton: UIButton {
  
  lazy var callback: (UIButton) -> () = { button in }
  
  func addHander(control: UIControlEvents, callback: @escaping (UIButton) -> ()) {
    self.callback = callback
    addTarget(self, action: #selector(handleTap), for: control)
  }
  
  @objc private func handleTap() {
    callback(self)
  }
}
