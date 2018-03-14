//
//  ViewController.swift
//  try_scale_img
//
//  Created by Wataru Maeda on 2018-03-13.
//  Copyright © 2018 Wataru Maeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let btn = UIButton()
    btn.frame = .zero
    btn.setTitle(" Present scaled image view ", for: .normal)
    btn.setTitleColor(.red, for: .normal)
    btn.sizeToFit()
    btn.center = view.center
    view.addSubview(btn)
    btn.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
  }
  
  @objc private func tappedButton() {
    print("tapped button!")
    
    let scaleImageView = ScaleImageView.generate()
    view.addSubview(scaleImageView)
  }
}


