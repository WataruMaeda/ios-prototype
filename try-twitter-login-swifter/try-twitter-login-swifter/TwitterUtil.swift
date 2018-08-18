
//
//  TwitterUtil.swift
//  try-twitter-login-swifter
//
//  Created by Wataru Maeda on 2018-08-17.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit
import Swifter

class TwitterUtil: NSObject {
  
  static func authorize(presentingFrom: UIViewController) {
    let swifter = Swifter(
      consumerKey: "51hfSGYFBNK16p1FhRRPWxyJV",
      consumerSecret: "eA6DVf2uJjNjujJciQBX8BsUDvuSAG3k1xXDrsGBA0eQ22P8tB"
    )
    guard let callbackURL = URL(string: "mmakeytwitter://success") else { return }
    
//    let swifter = Swifter(consumerKey: "nLl1mNYc25avPPF4oIzMyQzft",
//                          consumerSecret: "Qm3e5JTXDhbbLl44cq6WdK00tSUwa17tWlO8Bf70douE4dcJe2")
//    let callbackURL = URL(string: "swifter://success")!
    
    swifter.authorize(withCallback: callbackURL, presentingFrom: presentingFrom, success: { accessToken, response in
      print("success!")
      print(response)
    }, failure: { error in
      print("error!")
      print(error)
    })
  }
}
