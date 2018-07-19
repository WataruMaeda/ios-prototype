//
//  TutorialModelManager.swift
//  try-tutorial
//
//  Created by Wataru Maeda on 2018-07-03.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

struct UsersData: Decodable {
  var users: [User]
}

struct RecipesData: Decodable {
  var recipes: [Recipe]
}

struct User : Decodable {
  var name: String
  var image: String
}

struct Recipe : Decodable {
  var category: String
  var image: String
  var title: String
  var like: String
  var save: String
  var cosme_image_1: String
  var cosme_image_2: String
  var cosme_image_3: String
}

class TutorialModelManager {

  static func getUserList() -> [User]? {
    if let url = Bundle.main.url(forResource: "tutorial-users", withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let jsonData = try JSONDecoder().decode(UsersData.self, from: data)
        return jsonData.users
      } catch {
        print("error:\(error)")
      }
    }
    return nil
  }
  
  static func getRecipeList() -> [Recipe]? {
    if let url = Bundle.main.url(forResource: "tutorial-recipes", withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let jsonData = try JSONDecoder().decode(RecipesData.self, from: data)
        return jsonData.recipes
      } catch {
        print("error:\(error)")
      }
    }
    return nil
  }
  
}
