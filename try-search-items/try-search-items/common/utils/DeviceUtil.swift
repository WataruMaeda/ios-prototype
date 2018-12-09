//
//  DeviceUtil.swift
//  Copyright © 2017 wataru maeda. All rights reserved.
//

import UIKit

class DeviceUtil {
  
  static var width: CGFloat {
    return UIScreen.main.bounds.size.width
  }
  
  static var height: CGFloat {
    return UIScreen.main.bounds.size.height
  }
  
  static var maxLength: CGFloat {
    return max(width, height)
  }
  
  static var minLength: CGFloat {
    return min(width, height)
  }
  
  static var isPhone: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
  }
  
  static var isPad: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
  }
  
  static var isRetina: Bool {
    return UIScreen.main.scale >= 2.0
  }
  
  static var app_ver: String {
    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String { return version }
    return ""
  }
  
  static var isJp: Bool {
    return Locale.current.languageCode == "ja"
  }
  
  static var type : DeviceType {
    if isPhone && maxLength < 568 {
      return .iphone4
    } else if isPhone && maxLength == 568 {
      return .iphone5
    } else if isPhone && maxLength == 667 {
      return .iphone6
    } else if isPhone && maxLength == 736 {
      return .iphone6plus
    } else if isPhone && maxLength == 812 {
      return .iphoneX
    } else if isPad && !isRetina {
      return .iPadNonRetina
    } else if isPad && isRetina && maxLength == 1024 {
      return .iPad
    } else if isPad && maxLength == 1366 {
      return .iPadProBig
    }
    return .unknown
  }
}

public enum DeviceType {
  case unknown
  case iphone4
  case iphone5
  case iphone6
  case iphone6plus
  case iphoneX
  case iPadNonRetina
  case iPad
  case iPadProBig
}
