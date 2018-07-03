//
//  FirstTutorialViewController.swift
//  try-tutorial
//
//  Created by Wataru Maeda on 2018-07-03.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class FirstTutorialViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    fetchUsersFromJson()
  }
  
  fileprivate func fetchUsersFromJson() {
    guard let path = Bundle.main.path(
      forResource: "tutorial-users",
      ofType: "json"
      ) else { return }
    
    do {
      let data = try Data(
        contentsOf: URL(fileURLWithPath: path),
        options: .mappedIfSafe
      )
      let jsonResult = try JSONSerialization.jsonObject(
        with: data,
        options: .mutableLeaves
      )
      if let jsonResult = jsonResult as? Dictionary<String, AnyObject>,
        let person = jsonResult["person"] as? [Any] {
        print(person)
      }
    } catch {
      // handle error
    }
  }
}
