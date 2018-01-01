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

private enum MediaViewType {
    case image, video
}

class MediaView: UIView {
    
    private var type: MediaViewType  = .image {
        didSet {
            if type == .image {
                imageView.isHidden = false
                playerLayer.isHidden = true
            } else {
                imageView.isHidden = true
                playerLayer.isHidden = false
            }
        }
    }
    
    var image = UIImage() {
        didSet {
            type = .image
            imageView.image = image
            player.pause()
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var autoRepeat = true
    
    var videoUrl = "" {
        didSet {
            type = .video
            if videoUrl.contains("http") {
                guard let url = URL(string: videoUrl) else {
                    return print("[error] MediaView: Invalid URL")
                }
                player = AVPlayer(url: url)
            } else {
                let url = URL(fileURLWithPath: videoUrl)
                player = AVPlayer(url: url)
            }
        }
    }
    
    var player = AVPlayer() {
        didSet {
            addMediaViewObserver()
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

// MARK: - Notification Center

extension MediaView {
    
    private func addMediaViewObserver() {
        NotificationCenter.default.addObserver(self, selector:#selector(playerDidPlayToEndTime(notification:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    private func removeMediaViewObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func playerDidPlayToEndTime(notification: NSNotification) {
        if type == .video && autoRepeat {
            player.seek(to: kCMTimeZero)
            player.play()
        }
    }
    
    @objc private func appWillResignActive() {
        if type == .video { player.pause() }
    }
    
    @objc private func appDidBecomeActive() {
        if type == .video { player.play() }
    }
}

// MARK: - UIView Life Cycle

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
        removeMediaViewObserver()
        imageView.removeFromSuperview()
        playerLayer.removeFromSuperlayer()
    }
}

// MARK: - AVPLayer

extension MediaView {
    
    func isPlayingVideo() -> Bool {
        return (type == .video && player.rate != 0 && player.error == nil)
    }
    
    func playVideo() {
        if type == .video { player.play() }
    }
    
    func pauseVideo() {
        if type == .video { player.pause() }
    }
    
    func readyPlayVideo() {
        if type == .video {
            player.seek(to: kCMTimeZero)
            player.pause()
        }
    }
    
    func restartVideo() {
        if type == .video {
            player.seek(to: kCMTimeZero)
            player.play()
        }
    }
}
