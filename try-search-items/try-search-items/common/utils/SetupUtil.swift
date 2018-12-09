//
//  SetupUtil.swift
//  Copyright © 2018 wataru maeda. All rights reserved.
//

import UIKit
import SwiftRater

class SetupUtil: NSObject {

  static func setup() {
    
    // realm setup
    RealmUtil.setup()
    
    // ad setup
    AdUtil.shared.setup()
    
    // store setup
    StoreUtil.completeTransactions()
    
    // rater setup
    SwiftRater.daysUntilPrompt = 7
    SwiftRater.usesUntilPrompt = 10
    SwiftRater.significantUsesUntilPrompt = 3
    SwiftRater.daysBeforeReminding = 1
    SwiftRater.showLaterButton = true
    SwiftRater.debugMode = false
    SwiftRater.appLaunched()
  }
}
