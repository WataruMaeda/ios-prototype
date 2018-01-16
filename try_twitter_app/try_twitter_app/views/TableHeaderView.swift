//
//  TableHeaderView.swift
//  try_twitter_app
//
//  Created by Wataru Maeda on 2018/01/15.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class TableHeaderView: UIView {
  
  var maxPullingDistance = 250 as CGFloat
  
  lazy var overlayView: UIView = {
    let overlayView = UIView()
    overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    overlayView.alpha = 0
    return overlayView
  }()
  
  lazy var backgroundImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "background-image")
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.layer.borderColor = UIColor.yellow.cgColor
    imageView.layer.borderWidth = 5
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupViews()
  }
  
  private func setupViews() {
    backgroundColor = .white
    addSubview(backgroundImageView)
    addSubview(overlayView)
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    backgroundImageView.frame = bounds
    overlayView.frame = bounds
  }
}

extension TableHeaderView {
  
  func updateHeaderContentsSize(currentOffsetY: CGFloat) {
    if currentOffsetY < -maxPullingDistance {
      return
    } else if currentOffsetY >= 0 {
      backgroundImageView.frame = bounds
      overlayView.frame = bounds
      overlayView.alpha = 0
    } else {
      var rect = backgroundImageView.frame
      rect.origin.y = currentOffsetY
      rect.size.height = -currentOffsetY + frame.size.height
      backgroundImageView.frame = rect
      overlayView.frame = rect
      overlayView.alpha = currentOffsetY / -maxPullingDistance
    }
  }
}
