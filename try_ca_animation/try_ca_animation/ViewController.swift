//
//  ViewController.swift
//  try_ca_animation
//
//  Created by Wataru Maeda on 2017/12/16.
//  Copyright © 2017 com.watarumaeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let shapeLayer = CAShapeLayer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    
    let circulerPath = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
    
    // Track layer
    let trackLayer = CAShapeLayer()
    trackLayer.path = circulerPath.cgPath
    trackLayer.fillColor = UIColor.clear.cgColor
    trackLayer.strokeColor = UIColor.lightGray.cgColor
    trackLayer.lineWidth = 10
    view.layer.addSublayer(trackLayer)
    
    // Circle layer
    shapeLayer.path = circulerPath.cgPath
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = UIColor.red.cgColor
    shapeLayer.lineWidth = 10
    shapeLayer.lineCap = kCALineCapRound
    shapeLayer.strokeEnd = 0
    view.layer.addSublayer(shapeLayer)
    
    // Add tap gesture
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
  }
  
  fileprivate func animateCircle() {
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    basicAnimation.toValue = 1
    basicAnimation.duration = 2
    
    basicAnimation.fillMode = kCAFillModeForwards
    basicAnimation.isRemovedOnCompletion = false
    
    shapeLayer.add(basicAnimation, forKey: "strokeAnimation")
  }
  
  func beginDownloadingFile() {
    
  }
  
  @objc func handleTap() {
    beginDownloadingFile()
    animateCircle()
  }
}

