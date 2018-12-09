//
//  TimerUtil.swift
//  Copyright © 2017 Wataru Maeda. All rights reserved.
//

import UIKit

class TimerUtil {
  
    class func getElapsedTime(second: Int) -> String {
      
        // Second
        if second / 60 < 1 {
            return DeviceUtil.isJp ? "\(NSString(format: "%02d", second))秒" : "\(NSString(format: "00:%02d", second))"
        }
        
        // Hour
        if second / (60 * 60) >= 1 {
            let h = Int(second / (60 * 60))
            let min = Int((second - (h * 60 * 60)) / 60)
            let sec = second - Int(h * 60 * 60) - Int(min * 60)
            
            return DeviceUtil.isJp
              ? "\(NSString(format: "%02d", Int(h)))時間\(NSString(format: "%02d", Int(min)))分\(NSString(format: "%02d", Int(sec)))秒"
              : "\(NSString(format: "%02d", Int(h))):\(NSString(format: "%02d", Int(min))):\(NSString(format: "%02d", Int(sec)))"
        }
        
        // Min
        let min = Int(second / 60)
        let sec = second - Int(min * 60)
        
        return DeviceUtil.isJp
          ? "\(NSString(format: "%02d", Int(min)))分\(NSString(format: "%02d", Int(sec)))秒"
          : "\(NSString(format: "%02d", Int(min))):\(NSString(format: "%02d", Int(sec)))"
    }
}
