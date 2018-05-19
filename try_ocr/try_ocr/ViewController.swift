//
//  ViewController.swift
//  try_ocr
//
//  Created by Wataru Maeda on 2018-05-15.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    OcrService.detectTexts(from: #imageLiteral(resourceName: "eng2")) { texts in
      if let texts = texts {
        print(texts)
      } else {
        print("No Texts")
      }
    }
  }
}

