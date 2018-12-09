//
//  UIButtonCallback.swift
//  Copyright © 2018 wataru maeda. All rights reserved.
//

import UIKit

class UIButtonCallback: UIButton {

  private lazy var callback: (UIButton)->Void = { button in }
  
    func handleTap(event: UIControl.Event, callback: @escaping (UIButton)->Void) {
    self.callback = callback
    addTarget(self, action: #selector(tapped), for: event)
  }
  
  @objc private func tapped() {
    callback(self)
  }
}
