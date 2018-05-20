//
//  ViewController.swift
//  try_ocr
//
//  Created by Wataru Maeda on 2018-05-15.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit
import ACEDrawingView

let buttonHeight = 100 as CGFloat

class ViewController: UIViewController {
  
  let canvas = ACEDrawingView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCanvas()
    setupMenu()
  }
}

// MARK: - Drawer

extension ViewController {
  
  func setupCanvas() {
    canvas.frame = CGRect(
      x: 0, y: 0, width: view.viewWidth, height: view.viewHeight - buttonHeight)
    canvas.contentMode = .scaleAspectFit
    canvas.lineWidth = 6
    view.addSubview(canvas)
  }
  
  func setupMenu() {
    
    // clear button
    let clearButton = UIButton.generateButton(
      title: "Clear",
      frame: CGRect(
        x: 0,
        y: view.viewHeight - buttonHeight,
        width: view.viewWidth / 2,
        height: buttonHeight)) {
          self.canvas.clear()
    }
    view.addSubview(clearButton)
    
    // extract texts
    let extractButton = UIButton.generateButton(
      title: "Extract",
      frame: CGRect(
        x: view.viewWidth / 2,
        y: view.viewHeight - buttonHeight,
        width: view.viewWidth / 2,
        height: buttonHeight)) {
        self.detectTexts()
    }
    view.addSubview(extractButton)
  }
}

// MARK: - OCR

extension ViewController {
  
  func detectTexts() {
    guard let image = UIImage.convertToImage(view: canvas) else { return }
    
    // MARK: - * Image for OCR
    OcrService.detectTexts(from: image) { texts in
      if let texts = texts {
        var result = ""
        texts.forEach({ result += $0 })
        UIAlertController.show(self, title: result)
        print(texts)
      } else {
        UIAlertController.show(self, title: "Cannot detect text")
      }
    }
  }
}
