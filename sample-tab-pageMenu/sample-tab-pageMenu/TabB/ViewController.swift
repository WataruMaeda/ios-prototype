//
//  ViewController.swift
//  sample-tab-pageMenu
//
//  Created by Wataru Maeda on 2019-01-19.
//  Copyright © 2019 com.watarumaeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var callback: () -> Void = {}
  
  let label: UILabel = {
    let label = UILabel()
    label.text = "Tab B: ViewController"
    label.sizeToFit()
    return label
  }()
  
  let button: UIButton = {
    let button = UIButton()
    button.setTitle("タブ0へジャンプ", for: .normal)
    button.backgroundColor = .darkGray
    button.sizeToFit()
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    label.center = view.center
    view.addSubview(label)
    
    button.center = CGPoint(x: view.center.x, y: view.center.y + 100)
    button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    view.addSubview(button)
  }
  
  @objc func tapped() {
    callback()
  }
  
  func addSelectedHandler(callback: @escaping () -> Void = {}) {
    self.callback = callback
  }
}

