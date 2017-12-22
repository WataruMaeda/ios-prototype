//
//  ViewController.swift
//  mediaPicker
//
//  Created by Wataru Maeda on 2017/12/17.
//  Copyright © 2017 com.watarumaeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var mediaView1: MediaView! {
        didSet {
            mediaView1.image = #imageLiteral(resourceName: "placeholder")
            mediaView1.imageView.contentMode = .center
            mediaView1.handleTapGesture {
                self.showOptionAlert(mediaView: self.mediaView1)
            }
        }
    }
    @IBOutlet var mediaView2: MediaView! {
        didSet {
            mediaView2.image = #imageLiteral(resourceName: "placeholder")
            mediaView2.imageView.contentMode = .center
            mediaView2.handleTapGesture {
                self.showOptionAlert(mediaView: self.mediaView2)
            }
        }
    }
    @IBOutlet var mediaView3: MediaView! {
        didSet {
            mediaView3.image = #imageLiteral(resourceName: "placeholder")
            mediaView3.imageView.contentMode = .center
            mediaView3.handleTapGesture {
                self.showOptionAlert(mediaView: self.mediaView3)
            }
        }
    }
    @IBOutlet var mediaView4: MediaView! {
        didSet {
            mediaView4.image = #imageLiteral(resourceName: "placeholder")
            mediaView4.imageView.contentMode = .center
            mediaView4.handleTapGesture {
                self.showOptionAlert(mediaView: self.mediaView4)
            }
        }
    }
    @IBOutlet var mediaView5: MediaView! {
        didSet {
            mediaView5.image = #imageLiteral(resourceName: "placeholder")
            mediaView5.imageView.contentMode = .center
            mediaView5.handleTapGesture {
                self.showOptionAlert(mediaView: self.mediaView5)
            }
        }
    }
    @IBOutlet var mediaView6: MediaView! {
        didSet {
            mediaView6.image = #imageLiteral(resourceName: "placeholder")
            mediaView6.imageView.contentMode = .center
            mediaView6.handleTapGesture {
                self.showOptionAlert(mediaView: self.mediaView6)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func showOptionAlert(mediaView: MediaView) {
        let sheet = UIAlertController(title: "Video or image", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Photo (Camera)", style: .default) {action in
            MediaPicker.shared.getFromCamera(self, allowsEditing: true, imageCallback: { (image) in
                mediaView.image = image
                mediaView.imageView.contentMode = .scaleAspectFill
            })
        })
        sheet.addAction(UIAlertAction(title: "Photo (Library)", style: .default) {action in
            MediaPicker.shared.getFromLibrary(self, allowsEditing: true, imageCallback: { (image) in
                mediaView.image = image
                mediaView.imageView.contentMode = .scaleAspectFill
            })
        })
        sheet.addAction(UIAlertAction(title: "Video (Camera)", style: .default) {action in
            MediaPicker.shared.getFromCamera(self, allowsEditing: true, videoCallback: { (videoUrl) in
                mediaView.videoUrl = videoUrl
                mediaView.player.volume = 0
            })
        })
        sheet.addAction(UIAlertAction(title: "Video (Library)", style: .default) {action in
            MediaPicker.shared.getFromLibrary(self, allowsEditing: true, videoCallback: { (videoUrl) in
                mediaView.videoUrl = videoUrl
                mediaView.player.volume = 0
            })
        })
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel) {action in})
        present(sheet, animated: true, completion: nil)
    }
}

