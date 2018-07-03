//
//  TutorialModelManager.swift
//  try-tutorial
//
//  Created by Wataru Maeda on 2018-07-03.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

struct ResponseData: Decodable {
  var person: [Person]
}

struct Person : Decodable {
  var name: String
  var age: String
  var employed: String
}

class TutorialModelManager {

  static func loadUsersFromJson() -> [Person]? {
    if let url = Bundle.main.url(forResource: "tutorial-users", withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let jsonData = try JSONDecoder().decode(ResponseData.self, from: data)
        return jsonData.person
      } catch {
        print("error:\(error)")
      }
    }
    return nil
  }
  
}
