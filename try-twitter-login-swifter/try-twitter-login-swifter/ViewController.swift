//
//  ViewController.swift
//  try-twitter-login-swifter
//
//  Created by Wataru Maeda on 2018-08-17.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // twitter button
    let button = TwitterButton(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
    button.addLoginHander(presentingFrom: self) { (accessToken, response) in
      print(accessToken ?? "token is nil")
      print(response)
    }
    button.center = view.center
    view.addSubview(button)
  }
}

