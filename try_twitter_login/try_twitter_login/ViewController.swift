//
//  ViewController.swift
//  try_twitter_login
//
//  Created by Wataru Maeda on 2017/12/11.
//  Copyright © 2017 com.watarumaeda. All rights reserved.
//

import UIKit
import SafariServices
import TwitterKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    initTwitterLoginButton()
  }
  
  func initTwitterLoginButton() {
    let logInButton = TWTRLogInButton(logInCompletion: { session, error in
      if (session != nil) {
        print("signed in as \(String(describing: session?.userName))");
      } else {
        print("error: \(String(describing: error?.localizedDescription))");
      }
    })
    logInButton.center = self.view.center
    self.view.addSubview(logInButton)
  }
}
