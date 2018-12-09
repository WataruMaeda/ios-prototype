//
//  UIView+Ext.swift
//  Copyright © 2018 wataru maeda. All rights reserved.
//

import UIKit

// MARK: - Anchor

extension UIView {
  
  func fillAnchor() {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
      rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
      topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
      bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
  }
  
  func anchor(_ top: NSLayoutYAxisAnchor? = nil,
              left: NSLayoutXAxisAnchor? = nil,
              bottom: NSLayoutYAxisAnchor? = nil,
              right: NSLayoutXAxisAnchor? = nil,
              topConstant: CGFloat = 0,
              leftConstant: CGFloat = 0,
              bottomConstant: CGFloat = 0,
              rightConstant: CGFloat = 0,
              widthConstant: CGFloat = 0,
              heightConstant: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    _ = anchorWithReturnAnchors(top,
                                left: left,
                                bottom: bottom,
                                right: right,
                                topConstant: topConstant,
                                leftConstant: leftConstant,
                                bottomConstant: bottomConstant,
                                rightConstant: rightConstant,
                                widthConstant: widthConstant,
                                heightConstant: heightConstant)
  }
  
  func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil,
                               left: NSLayoutXAxisAnchor? = nil,
                               bottom: NSLayoutYAxisAnchor? = nil,
                               right: NSLayoutXAxisAnchor? = nil,
                               topConstant: CGFloat = 0,
                               leftConstant: CGFloat = 0,
                               bottomConstant: CGFloat = 0,
                               rightConstant: CGFloat = 0,
                               widthConstant: CGFloat = 0,
                               heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
    translatesAutoresizingMaskIntoConstraints = false
    var anchors = [NSLayoutConstraint]()
    
    if let top = top {
      anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
    }
    
    if let left = left {
      anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
    }
    
    if let bottom = bottom {
      anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
    }
    
    if let right = right {
      anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
    }
    
    if widthConstant > 0 {
      anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
    }
    
    if heightConstant > 0 {
      anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
    }
    anchors.forEach({$0.isActive = true})
    
    return anchors
  }
  
  func anchorCenterXToSuperview(constant: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    if let anchor = superview?.centerXAnchor {
      centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
  }
  
  func anchorCenterYToSuperview(constant: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    if let anchor = superview?.centerYAnchor {
      centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
  }
  
  func anchorCenterSuperview() {
    anchorCenterXToSuperview()
    anchorCenterYToSuperview()
  }
}

// MARK: - Size & Position

extension UIView {
  
  var viewX: CGFloat {
    get { return frame.origin.x }
  }
  
  var viewMinX: CGFloat {
    get { return frame.minX }
  }
  
  var viewMidX: CGFloat {
    get { return frame.midX }
  }
  
  var viewMaxX: CGFloat {
    get { return frame.maxX }
  }
  
  var viewY: CGFloat {
    get { return frame.origin.y }
  }
  
  var viewMinY: CGFloat {
    get { return frame.minY }
  }
  
  var viewMidY: CGFloat {
    get { return frame.midY }
  }
  
  var viewMaxY: CGFloat {
    get { return frame.maxY }
  }
  
  var viewWidth: CGFloat {
    get { return frame.size.width }
  }
  
  var viewHeight: CGFloat {
    get { return frame.size.height }
  }
  
  func isHeigherThanEstimate(height: CGFloat) -> Bool {
    let estimateHeight = sizeThatFits(CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
    return estimateHeight > height
  }
  
  func sizeWidthFit() {
    let estimateHeight = sizeThatFits(
      CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height + 15
    var size = frame.size
    size.height = estimateHeight
    frame.size = size
  }
  
  func sizeToFitSubviews() {
    var size = frame.size
    for subview in subviews {
      if subview.frame.maxY > frame.size.height {
        size.height = subview.frame.maxY
        frame.size = size
      }
    }
  }
}

// MARK: - Animation

extension UIView {
  
  func scaleAnimation(to: CGFloat, duration: CFTimeInterval, repeats: Bool) {
    let animation = CABasicAnimation(keyPath: "transform.scale")
    animation.toValue = to
    animation.duration = duration
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    animation.autoreverses = repeats
    
    if !repeats {
      animation.fillMode = kCAFillModeForwards
      animation.isRemovedOnCompletion = false
    } else {
      animation.repeatCount = Float.infinity
    }
    
    layer.add(animation, forKey: "pulsing")
  }
  
  func bounceAnimation() {
    let forward = CATransform3DMakeScale(1.1, 1.1, 1)
    let back = CATransform3DMakeScale(0.9, 0.9, 1)
    let forward2 = CATransform3DMakeScale(1, 1, 1)
    let animation = CAKeyframeAnimation(keyPath: "transform")
    animation.values = [
      NSValue(caTransform3D: CATransform3DIdentity),
      NSValue(caTransform3D: forward),
      NSValue(caTransform3D: back),
      NSValue(caTransform3D: forward2)
    ]
    animation.keyTimes = [0, 0.3, 0.6, 1]
    animation.duration = 0.3
    layer.add(animation, forKey: "transform")
  }
  
  func shakeAnimation() {
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.07
    animation.repeatCount = 2
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 5, y: center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + 5, y: center.y))
    layer.add(animation, forKey: "position")
  }
  
  func roundAnimation(callback: @escaping ()->()) {
    CATransaction.begin()
    CATransaction.setCompletionBlock({
      callback()
    })
    let rotationAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
    rotationAnimation.toValue = CGFloat(Double.pi / 180) * 360
    rotationAnimation.duration = 0.04
    rotationAnimation.repeatCount = 1
    layer.add(rotationAnimation, forKey: "rotationAnimation")
    CATransaction.commit()
  }
  
  func wiggleAnimation() {
    let animation = CAKeyframeAnimation(keyPath:"transform")
    let angle = 0.03 as CGFloat
    animation.values = [CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0),
                        CATransform3DMakeRotation(-angle, 0.0, 0.0, 1.0)]
    animation.autoreverses = true
    animation.duration = 0.125
    animation.repeatCount = Float.infinity
    layer.add(animation, forKey: "transform")
    
  }
}

// MARK: - Supporting

extension UIView {
  
  func conevrtToImage() -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
    guard let context = UIGraphicsGetCurrentContext() else { return nil }
    self.layer.render(in: context)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
}
