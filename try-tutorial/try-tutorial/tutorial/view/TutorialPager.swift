//
//  TutorialPager.swift
//  try-tutorial
//
//  Created by Wataru Maeda on 2018-07-04.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class TutorialPager: UIView {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descLabel: UILabel!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var skipButton: UIButton!
  @IBOutlet weak var startButton: UIButton! {
    didSet {
      startButton.layer.shadowColor = UIColor.lightGray.cgColor
      startButton.layer.shadowOffset = CGSize(width: 1, height: 1);
      startButton.layer.shadowOpacity = 0.2
      startButton.layer.cornerRadius = 5
    }
  }
}

extension TutorialPager {
  
  func setupContents(_ page: Int) {
    if (page == 1) {
      titleLabel.text = "メイクが上手な人がたくさんいるよ"
      descLabel.text = "気になった人をフォローしよう"
    } else if (page == 2) {
      titleLabel.text = "いろんなタイプのメイクがあるよ"
      descLabel.text = "スクールメイク、休日用メイクの参考にしよう"
    } else if (page == 3) {
      titleLabel.text = "メイクが詳しく見れるよ"
      descLabel.text = "メイクの手順や使ったコスメを見よう"
    } else if (page == 4) {
      titleLabel.text = "メイクの手順が見れるよ"
      descLabel.text = "手順をなぞって、自分に合うメイクを見つけてみて"
    }
    pageControl.currentPage = page - 1
    startButton.isHidden = page != 4
    skipButton.isHidden = !startButton.isHidden
  }
}
