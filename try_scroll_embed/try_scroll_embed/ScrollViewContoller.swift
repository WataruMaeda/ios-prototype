//
//  ScrollViewContoller.swift
//  try_scroll_embed
//
//  Created by Wataru Maeda on 2018/01/24.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class ScrollViewContoller: UIViewController {
  
  var headerImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
    imageView.clipsToBounds = true
    imageView.image = #imageLiteral(resourceName: "header")
    return imageView
  }()
  
  var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    return scrollView
  }()
  
  let embededViewContoller = EmbededViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    view.addSubview(scrollView)
    scrollView.addSubview(headerImage)
    scrollView.addSubview(embededViewContoller.view)
    embededViewContoller.view.frame = CGRect(x: 0, y: 300, width: view.viewWidth, height: view.viewHeight)
    embededViewContoller.didMove(toParentViewController: self)
    
    scrollView.fillAnchor()
    
//    headerImage.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: view.viewHeight, rightConstant: 0, widthConstant: 0, heightConstant: headerImage.viewHeight)
//
//    embededViewContoller.view.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: headerImage.viewHeight, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: view.viewHeight)
    
    scrollView.contentSize.height = 2000
  }
}
