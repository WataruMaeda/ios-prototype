//
//  ViewControllerB.swift
//  sample-tab-pageMenu
//
//  Created by Wataru Maeda on 2019-01-19.
//  Copyright © 2019 com.watarumaeda. All rights reserved.
//

import UIKit

class ViewControllerB: UIViewController {
  
  let label: UILabel = {
    let label = UILabel()
    label.text = "Tab A: ViewControllerB"
    label.sizeToFit()
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    label.center = view.center
    view.addSubview(label)
  }
}
