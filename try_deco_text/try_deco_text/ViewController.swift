//
//  ViewController.swift
//  try_deco_text
//
//  Created by Wataru Maeda on 2018-05-22.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var label: UILabel! {
    didSet {
      label.frame = UIScreen.main.bounds
      label.text = "1111<em>2222<em>3333<em>4444<em>"
      label.font = UIFont.systemFont(ofSize: 20)
      label.textAlignment = .center
      label.numberOfLines = 0
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    label = UILabel()
    view.addSubview(label)
    decoText()
  }
}

extension ViewController {
  
  func decoText() {
    let text = "011112222<em>33334444ddddd"
    
//    let range: Range<String.Index> = text.range(of: "<em>")!
//    let index: Int = text.distance(from: text.startIndex, to: range.lowerBound)
//    print(index)
    
    var arr = text.components(separatedBy: "<em>")
    print(arr)
  }
}
