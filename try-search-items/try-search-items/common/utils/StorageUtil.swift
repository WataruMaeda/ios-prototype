//
//  StorageUtil.swift
//  Copyright © 2017 Wataru Maeda. All rights reserved.
//

import UIKit

// MARK: - Setter

class StorageUtil {
  
  fileprivate static let ud = UserDefaults.standard
  
  // String
  static func setStr(_ str: String, key: String) -> Bool {
    ud.set(str, forKey: key)
    return ud.synchronize()
  }
  
  // Int
  static func setInt(_ int: Int, key: String) -> Bool {
    ud.set(int, forKey: key)
    return ud.synchronize()
  }
 
  // Bool
  static func setBool(_ bool: Bool, key: String) -> Bool {
    ud.set(bool, forKey: key)
    return ud.synchronize()
  }
  
  // Object
  static func setObj(_ obj: AnyObject, key: String) -> Bool {
    ud.set(obj, forKey: key)
    return ud.synchronize()
  }
  
  // Array
  static func setStrArr(_ arr: [String], key: String) -> Bool {
    ud.set(arr, forKey: key)
    return ud.synchronize()
  }
}

// MARK: - Geter

extension StorageUtil {
  
  static func strForKey(_ key: String) -> String? {
    return ud.string(forKey: key)
  }
  
  static func intForKey(_ key: String) -> Int {
    return ud.integer(forKey: key)
  }
  
  static func boolForKey(_ key: String) -> Bool {
    return ud.bool(forKey: key)
  }
  
  static func objForKey(_ key: String) -> AnyObject? {
    return ud.object(forKey: key) as AnyObject
  }
  
  static func strArrForKey(_ key: String) -> [String]? {
    return ud.stringArray(forKey: key)
  }
}

