//
//  ScaleImageView.swift
//  try_scale_img
//
//  Created by Wataru Maeda on 2018-03-13.
//  Copyright © 2018 Wataru Maeda. All rights reserved.
//

import UIKit

class ScaleImageView: BaseScaleImageView {
  
  fileprivate lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.frame = bounds
    imageView.backgroundColor = .lightGray
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return imageView
  }()
  
  static func generate() -> UIView {
    let scaleImageView = ScaleImageView()
    scaleImageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
    return scaleImageView
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupViews()
  }
}

// MARK: - UI

extension ScaleImageView {
  
  fileprivate func setupViews() {
    backgroundColor = .white
    addSubview(imageView)
    
    if let url = URL(string: "https://cdn.pixabay.com/photo/2018/02/26/16/44/bird-3183441_960_720.jpg") {
      downloadImage(url: url, completion: { image in
        self.imageView.image = image
      })
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
