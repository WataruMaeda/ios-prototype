//
//  TwitterButton.swift
//  try-twitter-login-swifter
//
//  Created by Wataru Maeda on 2018-08-20.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit
import Swifter

class TwitterButton: UIButton {
  
  fileprivate lazy var presentingFrom = UIViewController()
  fileprivate lazy var loginCallback: (Credential.OAuthAccessToken?, URLResponse)->Void = { (token, response) in }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    applyButtonStyle()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    applyButtonStyle()
  }
  
  private func applyButtonStyle() {
    backgroundColor = UIColor(red:0.114, green:0.632, blue:0.952, alpha:1.000)
    setImage(#imageLiteral(resourceName: "twitter").withRenderingMode(.alwaysTemplate), for: .normal)
    setTitle(" Twitterにログイン", for: .normal)
    titleLabel?.font = UIFont.systemFont(ofSize: 16)
    setTitleColor(.white, for: .normal)
    setTitleColor(.gray, for: .highlighted)
    imageView?.contentMode = .scaleAspectFit
    imageView?.tintColor = .white
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    imageView?.tintColor = .white
  }
}

// MARK: - Twitter Login

extension TwitterButton {
  
  func addLoginHander(presentingFrom: UIViewController,
                      loginCallback: @escaping (Credential.OAuthAccessToken?, URLResponse)->Void) {
    self.presentingFrom = presentingFrom
    self.loginCallback = loginCallback
    addTarget(self, action: #selector(authorize), for: .touchUpInside)
  }
  
  @objc private func authorize() {
    
    // test key
    let swifter = Swifter(consumerKey: "nLl1mNYc25avPPF4oIzMyQzft",
                          consumerSecret: "Qm3e5JTXDhbbLl44cq6WdK00tSUwa17tWlO8Bf70douE4dcJe2")
    guard let callbackURL = URL(string: "swifter://success") else { return }

    // ask for auth
    swifter.authorize(withCallback: callbackURL, presentingFrom: presentingFrom, success: { accessToken, response in
      self.loginCallback(accessToken, response)
    }, failure: { error in
      print(error)
    })
  }
}
