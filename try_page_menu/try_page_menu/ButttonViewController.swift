//
//  ButttonViewController.swift
//  try_page_menu
//
//  Created by Wataru Maeda on 2017/12/05.
//  Copyright © 2017 com.wataru.maeda. All rights reserved.
//

import UIKit

class ButttonViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let button = UIButton()
    button.clipsToBounds = true
    button.backgroundColor = .clear
    button.setTitle("Tap!", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
    button.setTitleColor(.white, for: .normal)
    button.layer.borderColor = button.titleLabel?.textColor.cgColor ?? UIColor.white.cgColor
    button.layer.borderWidth = 3
    button.layer.cornerRadius = 150
    button.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
    button.center = view.center
    button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    view.addSubview(button)
  }
  
  @objc func tapped() {
    print("tapped")
  }
}
