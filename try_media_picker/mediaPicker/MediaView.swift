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
    case image, localVideo, remoteVideo
}

class MediaView: UIView {
    
    private var type = MediaViewType.image
    
    var image = UIImage() {
        didSet {
            type = .image
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
    
    var videoUrl = "" {
        didSet {
            if videoUrl.contains("http") {
                type = .remoteVideo
                guard let url = URL(string: videoUrl) else { return }
                player = AVPlayer(url: url)
            } else {
                type = .localVideo
                let url = URL(fileURLWithPath: videoUrl)
                player = AVPlayer(url: url)
            }
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
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func playerFailedToPlayToEndTime(notification: NSNotification) {
        if type == .localVideo || type == .remoteVideo {
            player.seek(to: kCMTimeZero)
            player.play()
            imageView.isHidden = true
            playerLayer.isHidden = false
        } else {
            imageView.isHidden = false
            playerLayer.isHidden = true
        }
    }
    
    @objc private func playerDidPlayToEndTime(notification: NSNotification) {
        if type == .localVideo || type == .remoteVideo {
            player.seek(to: kCMTimeZero)
            player.play()
            imageView.isHidden = true
            playerLayer.isHidden = false
        } else {
            imageView.isHidden = false
            playerLayer.isHidden = true
        }
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
