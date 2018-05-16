//
//  ScaleImageView.swift
//  try_scale_img
//
//  Created by Wataru Maeda on 2018-03-13.
//  Copyright © 2018 Wataru Maeda. All rights reserved.
//

import UIKit
import Spring

class ScaleImageView: SpringView {
  
  fileprivate lazy var imageView: SpringImageView = {
    let imageView = SpringImageView()
    imageView.frame = bounds
    imageView.backgroundColor = .lightGray
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return imageView
  }()
  
  static func generate() -> UIView {
    let scaleImageView = ScaleImageView()
    scaleImageView.frame = UIScreen.main.bounds
    return scaleImageView
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupContents()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupViews()
    setupContents()
  }
}

// MARK: - UI

extension ScaleImageView {
  
  fileprivate func setupViews() {
    backgroundColor = UIColor.black.withAlphaComponent(0.4)
    addSubview(imageView)
    
//    let margin = 32 as CGFloat
//    imageView.frame = CGRect(
//      x: margin,
//      y: margin,
//      width: frame.size.width - margin * 2,
//      height: frame.size.height - margin * 2
//    )
  }
  
  fileprivate func setupContents() {
    if let url = URL(string: "https://cdn.pixabay.com/photo/2018/02/26/16/44/bird-3183441_960_720.jpg") {
      downloadImage(url: url, completion: { image in
        self.imageView.image = image
      })
    }
  }
}

// MARK: - Animation

extension ScaleImageView {
  
  override func addSubview(_ view: UIView) {
    super.addSubview(view)
    animation = "fadeIn"
    animate()
    imageView.isHidden = false
    imageView.animation = "slideUp"
    imageView.animate()
  }
  
  internal func fadeOut() {
    imageView.animation = "fadeOut"
    imageView.animate()
    animation = "fadeOut"
    animateNext{ () -> () in
      self.imageView.removeFromSuperview()
      self.removeFromSuperview()
    }
  }
  
  internal func dismiss() {
    imageView.animation = "fall"
    imageView.animate()
    animation = "fadeOut"
    animateNext{ () -> () in
      self.imageView.removeFromSuperview()
      self.removeFromSuperview()
    }
  }
}

// MARK: - Supporting functions

extension ScaleImageView {
  
  func downloadImage(url: URL, completion: @escaping (UIImage?)->Void) {
    getDataFromUrl(url: url) { data, response, error in
      guard let data = data, error == nil else {
        return completion(nil)
      }
      DispatchQueue.main.async() {
        let image = UIImage(data: data)
        completion(image)
      }
    }
  }
  
  private func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      completion(data, response, error)
      }.resume()
  }
}
