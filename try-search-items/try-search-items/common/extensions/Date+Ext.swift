//
//  Date+Ext.swift
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

extension Date {
  
  static func indexOfWeek() -> Int {
    // "Sun"->1,"Mon"->2,"Thue"->3,"Wed"->4,"Thr"->5,"Fri"->6,"Sat"->7
    return Calendar.current.dateComponents([.weekday], from: Date()).weekday ?? 1
  }
  
  static func localDate() -> Date? {
    return Date(timeIntervalSinceNow: TimeInterval(TimeZone.current.secondsFromGMT()))
  }
  
  static func daysAgo(day: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: -day, to: Date()) ?? Date()
  }
  
  static func hoursAgo(hour: Int) -> Date {
    return Calendar.current.date(byAdding: .hour, value: -hour, to: Date()) ?? Date()
  }
  
  static func minutsAgo(minute: Int) -> Date {
    return Calendar.current.date(byAdding: .minute, value: -minute, to: Date()) ?? Date()
  }
  
  static func secAgo(second: Int) -> Date {
    return Calendar.current.date(byAdding: .second, value: -second, to: Date()) ?? Date()
  }
  
  static func getYMDToday()-> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: Date())
  }
}

// MARk : - Converter

extension Date {
  
  static func dateToString()-> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = DateFormatter.Style.short
    return dateFormatter.string(from: Date())
  }
  
  static func stringToDate(strDate: String)-> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd hh:mm:ss Z"
    return formatter.date(from: strDate)
  }
}
