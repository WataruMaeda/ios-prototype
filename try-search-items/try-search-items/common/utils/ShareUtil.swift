//
//  ShareUtil.swift
//  Copyright © 2017 Wataru Maeda. All rights reserved.
//

import UIKit
import Social

let storeUrl = DeviceUtil.isJp
  ? "https://itunes.apple.com/jp/app/{appId}"
  : "https://itunes.apple.com/app/{appid}"

class ShareUtil {
  
  class func shareLine(_ text: String) {
    guard let message = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
    guard let url = URL(string: "line://msg/text/\(message)") else { return }
    guard UIApplication.shared.canOpenURL(url) else { return }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}
