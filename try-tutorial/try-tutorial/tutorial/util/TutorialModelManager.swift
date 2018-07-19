//
//  TutorialModelManager.swift
//  try-tutorial
//
//  Created by Wataru Maeda on 2018-07-03.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

struct ResponseData: Decodable {
  var user: [User]
}

struct User : Decodable {
  var name: String
  var image: String
}

class TutorialModelManager {

  static func getUserList() -> [User]? {
    if let url = Bundle.main.url(forResource: "tutorial-users", withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let jsonData = try JSONDecoder().decode(ResponseData.self, from: data)
        return jsonData.user
      } catch {
        print("error:\(error)")
      }
    }
    return nil
  }
  
}
