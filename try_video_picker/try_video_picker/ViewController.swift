//
//  ViewController.swift
//  try_video_picker
//
//  Created by Wataru Maeda on 2017/11/23.
//  Copyright © 2017 com.wmaeda. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
  
  var vidUrl = "" {
    didSet {
      let url = URL(fileURLWithPath: vidUrl)
      player = AVPlayer(url: url)
    }
  }
  var player = AVPlayer() {
    didSet {
      palceholerLabel.isHidden = true
      playerLayer.player = player
      player.play()
    }
  }
  var playerLayer = AVPlayerLayer()
  lazy var palceholerLabel: UILabel = {
    let label = UILabel()
    label.text = "Please take or record video"
    label.textColor = .white
    label.sizeToFit()
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initSubviews()
  }
  
  func initSubviews() {
    playerLayer.frame = CGRect(x: 0,y: 0,
                               width: view.frame.size.width,
                               height: view.frame.size.height - 50)
    playerLayer.backgroundColor = UIColor.gray.cgColor
    view.layer.addSublayer(playerLayer)
    
    palceholerLabel.center = view.center
    view.addSubview(palceholerLabel)
    
    let button = UIButton()
    button.frame = CGRect(x: 0, y: view.frame.size.height - 50,
                          width: view.frame.size.width, height: 50)
    button.setTitle("Show Options", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
    view.addSubview(button)
  }
  
  @objc func showMenu() {
    let alert = UIAlertController(
      title: "Video Picker",
      message: "Select option",
      preferredStyle: .actionSheet
    )
    alert.addAction(UIAlertAction(title: "Record", style: .default) {action in
      VideoPicker.record(self) { (videoPath) in
        print("#Record: " + videoPath)
        self.vidUrl = videoPath
      }
    })
    alert.addAction(UIAlertAction(title: "Select", style: .default) {action in
      VideoPicker.select(self, callback: { (videoPath) in
        print("#Select" + videoPath)
        self.vidUrl = videoPath
      })
    })
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) {action in })
    present(alert, animated: true, completion: nil)
  }
}

