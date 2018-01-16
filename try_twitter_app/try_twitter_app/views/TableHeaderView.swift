//
//  TableHeaderView.swift
//  try_twitter_app
//
//  Created by Wataru Maeda on 2018/01/15.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit
import AudioToolbox

class TableHeaderView: UIView {
  
  var maxPullingDistance = 150 as CGFloat
  var directinAppearDistance = 60 as CGFloat
  var directinBecomeLoaderDistance = 80 as CGFloat
  
  fileprivate var isInDirectionAppearAnimation = false
  
  fileprivate lazy var backgroundImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = #imageLiteral(resourceName: "background-image")
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  fileprivate lazy var overlayView: UIVisualEffectView = {
    let blurEffect = UIBlurEffect(style: .light)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.alpha = 0
    return blurEffectView
  }()
  
  fileprivate lazy var directionImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.alpha = 0
    imageView.image = #imageLiteral(resourceName: "direction")
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFit
    imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
    return imageView
  }()
  
  fileprivate lazy var indicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    indicator.hidesWhenStopped = true
    return indicator
  }()
  
  fileprivate let generator = UIImpactFeedbackGenerator(style: .heavy)
  
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
    addSubview(directionImageView)
    addSubview(indicator)
    generator.prepare()
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    backgroundImageView.frame = bounds
    overlayView.frame = bounds
    directionImageView.center = overlayView.center
    indicator.center = overlayView.center
  }
}

extension TableHeaderView {
  
  func updateHeaderContentsSize(currentOffsetY: CGFloat) {
    
    if currentOffsetY >= 0 {
      // scroll down
      backgroundImageView.frame = bounds
      overlayView.frame = bounds
      overlayView.alpha = 0
      directionImageView.center = overlayView.center
      indicator.center = overlayView.center
    } else {
      // pull to refresh
      var rect = backgroundImageView.frame
      rect.origin.y = currentOffsetY
      rect.size.height = -currentOffsetY + frame.size.height
      backgroundImageView.frame = rect
      overlayView.frame = rect
      overlayView.alpha = currentOffsetY / -maxPullingDistance
      directionImageView.center = overlayView.center
      indicator.center = overlayView.center
      
      // show/hide direction image + loader
      controllProgress(currentOffsetY)
    }
  }
  
  private func controllProgress(_ currentOffsetY: CGFloat) {
    
    // 1: Show direction image
    if currentOffsetY < -directinAppearDistance &&
      directionImageView.alpha != 1 &&
      !isInDirectionAppearAnimation &&
      !indicator.isAnimating {
      
      // start animation
      isInDirectionAppearAnimation = true
      UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations: {
        self.directionImageView.alpha = 1
      }, completion: { finished in
        self.isInDirectionAppearAnimation = false
      })
      
    // 2: show indicator
    } else if currentOffsetY < -directinBecomeLoaderDistance &&
      directionImageView.alpha == 1 &&
      !isInDirectionAppearAnimation &&
      !indicator.isAnimating {
      
      // start animation
      isInDirectionAppearAnimation = true
      
      // make impact
      generator.impactOccurred()
      
      // begin rotation animation
      CATransaction.begin()
      CATransaction.setCompletionBlock({
        
        // did complete rotation animation -> show indicator
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations: {
          self.directionImageView.alpha = 0
        }, completion: { finished in
          self.indicator.startAnimating()
          self.isInDirectionAppearAnimation = false
          
          // remove layer animation
          self.directionImageView.layer.removeAllAnimations()
          
          // FIXME: call refresh function in here
          DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.indicator.stopAnimating()
          }
        })
      })
      let layer = directionImageView.layer
      let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
      animation.toValue = CGFloat.pi
      animation.duration = 0.1
      animation.fillMode = kCAFillModeForwards
      animation.autoreverses = false
      animation.isRemovedOnCompletion = false
      layer.add(animation, forKey: "ImageViewRotation")
      CATransaction.commit()
      
    // 3: hide direction
    } else if currentOffsetY > -directinAppearDistance &&
      directionImageView.alpha == 1 &&
      !isInDirectionAppearAnimation {
      
      // start animation
      isInDirectionAppearAnimation = true
      UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations: {
        self.directionImageView.alpha = 0
      }, completion: { finished in
        self.isInDirectionAppearAnimation = false
      })
    }
  }
}
