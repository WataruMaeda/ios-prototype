//
//  RealmUtil.swift
//  Copyright © 2018 wataru maeda. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: - Setup

class RealmUtil: NSObject {
  
  private static let currentSchemaVersion: UInt64 = 0
  
  static func setup() {
    RealmUtil.migrateIfNeeded()
    RealmUtil.compactRealmFile()
  }
}

// MARK: - Setup

extension RealmUtil {

  fileprivate static func compactRealmFile() {
    guard let defaultURL = Realm.Configuration.defaultConfiguration.fileURL else {
      return
    }
    
    let defaultParentURL = defaultURL.deletingLastPathComponent()
    let compactedURL = defaultParentURL.appendingPathComponent("app.realm")
    
    if FileManager.default.fileExists(atPath: defaultURL.path) {
      autoreleasepool {
        let realm = try? Realm()
        let _ = try? realm?.writeCopy(toFile: compactedURL)
        let _ = try? FileManager.default.removeItem(at: defaultURL)
        let _ = try? FileManager.default.moveItem(at: compactedURL, to: defaultURL)
      }
    }
  }
  
  fileprivate static func migrateIfNeeded() {
    let config = Realm.Configuration(
      schemaVersion: currentSchemaVersion,
      migrationBlock: { migration, oldSchemaVersion in
        if (oldSchemaVersion < currentSchemaVersion) {
        }
    })
    Realm.Configuration.defaultConfiguration = config
  }
}
