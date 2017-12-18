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
    
    var player = AVPlayer() {
        didSet {
            addPlayerObserver()
            playerLayer.player = player
            player.play()
        }
    }
    lazy var playerLayer = AVPlayerLayer()
    private lazy var tapCallback: () -> () = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    deinit { removeAll() }
}

// MARK: - Tap Gesture

extension MediaView {
    
    func handleTapGesture(callback: @escaping () -> ()) {
        tapCallback = callback
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        tapCallback()
    }
}

// MARK: - Player

extension MediaView {
    
    private func addPlayerObserver() {
        NotificationCenter.default.addObserver(self, selector:#selector(playerDidPlayToEndTime(notification:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        NotificationCenter.default.addObserver(self, selector:#selector(playerFailedToPlayToEndTime(notification:)),name: NSNotification.Name.AVPlayerItemFailedToPlayToEndTime, object: player.currentItem)
    }
    
    private func removePlayerObserver() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    
    @objc private func playerFailedToPlayToEndTime(notification: NSNotification) {
        player.seek(to: kCMTimeZero)
        player.play()
    }
    
    @objc private func playerDidPlayToEndTime(notification: NSNotification) {
        player.seek(to: kCMTimeZero)
        player.play()
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
        backgroundColor = .clear
        playerLayer.frame = bounds
        playerLayer.videoGravity = .resizeAspectFill
        imageView.frame = bounds
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
        imageView.frame = bounds
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        removeAll()
    }
    
    private func removeAll() {
        removePlayerObserver()
        imageView.removeFromSuperview()
        playerLayer.removeFromSuperlayer()
    }
}
