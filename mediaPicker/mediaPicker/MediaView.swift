//
//  MediaView.swift
//  mediaPicker
//
//  Created by Wataru Maeda on 2017/12/17.
//  Copyright © 2017 com.watarumaeda. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MediaView: UIView {
    
    var image = UIImage() {
        didSet {
            imageView.image = image
            player.pause()
            imageView.isHidden = false
            playerLayer.isHidden = true
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var videofileUrl = "" {
        didSet {
            let url = URL(fileURLWithPath: videofileUrl)
            player = AVPlayer(url: url)
            imageView.isHidden = true
            playerLayer.isHidden = false
        }
    }
    
    var videoUrl = "" {
        didSet {
            guard let url = URL(string: videoUrl) else { return }
            player = AVPlayer(url: url)
            imageView.isHidden = true
            playerLayer.isHidden = false
        }
    }
    
    private var player = AVPlayer() {
        didSet {
            playerLayer.player = player
            player.play()
        }
    }
    private lazy var playerLayer = AVPlayerLayer()
    private lazy var tapCallback: () -> () = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
        addPlayerObserver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
        addPlayerObserver()
    }
}

// MARK: - Tap Gesture

extension MediaView {
    
    func addTapGesture(callback: @escaping () -> ()) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
        tapCallback = callback
    }
    
    @objc private func handleTap() {
        tapCallback()
    }
}

// MARK: - Player

extension MediaView {
    
    private func addPlayerObserver() {
        NotificationCenter.default.addObserver(self, selector:#selector(playerDidFinishPlaying(notification:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    
    private func removePlayerObserver() {
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.AVPlayerItemDidPlayToEndTime,
                                                  object: nil)
    }
    
    @objc func playerDidFinishPlaying(notification: NSNotification) {
        player.seek(to: kCMTimeZero)
    }
}

// MARK: - UI

extension MediaView {
    
    private func initSubviews() {
        layer.addSublayer(playerLayer)
        addSubview(imageView)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        playerLayer.frame = bounds
        imageView.frame = bounds
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
        imageView.frame = bounds
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        removePlayerObserver()
        imageView.removeFromSuperview()
        playerLayer.removeFromSuperlayer()
    }
}
