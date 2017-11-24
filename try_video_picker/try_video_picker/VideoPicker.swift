//
//  VideoPicker.swift
//  try_video_picker
//
//  Created by Wataru Maeda on 2017/11/23.
//  Copyright © 2017 com.wmaeda. All rights reserved.
//

import UIKit
import MobileCoreServices

typealias GetVideo = (_ videoPath: String) -> ()

// MARK: - VideoPicker

class VideoPicker: NSObject {
  class func record(_ presentViewController: UIViewController,
                          callback: @escaping GetVideo) {
    MediaManager.shared.recordVideo(presentViewController) { (videoPath) in
      callback(videoPath)
    }
  }
  
  class func select(_ presentViewController: UIViewController,
                    callback: @escaping GetVideo) {
    MediaManager.shared.selectVideo(presentViewController) { (videoPath) in
      callback(videoPath)
    }
  }
}

// MARK: - MediaManager

class MediaManager: NSObject {
  static var shared = MediaManager()
  private override init() {}
  fileprivate var callback: GetVideo?
  
  func recordVideo(_ presentViewController: UIViewController,
                   callback: @escaping GetVideo) {
    let picker = UIImagePickerController()
    picker.sourceType = .camera
    picker.cameraDevice = .rear
    picker.mediaTypes = [kUTTypeMovie as String]
    picker.cameraCaptureMode = .video
    picker.allowsEditing = true
    picker.delegate = self
    presentViewController.present(picker, animated: true, completion: nil)
    self.callback = callback
  }
  
  func selectVideo(_ presentViewController: UIViewController,
                        callback: @escaping GetVideo) {
    let picker = UIImagePickerController()
    picker.sourceType = .photoLibrary
    picker.mediaTypes = [kUTTypeMovie as String]
    picker.allowsEditing = true
    picker.delegate = self
    presentViewController.present(picker, animated: true, completion: nil)
    self.callback = callback
  }
}

// MARK: - UIImagePickerControllerDelegate

extension MediaManager: UIImagePickerControllerDelegate {
  public func imagePickerController(_ picker: UIImagePickerController,
                                    didFinishPickingMediaWithInfo info: [String : Any]) {
    picker.dismiss(animated: true, completion: nil)
    guard let mediaType = info[UIImagePickerControllerMediaType] as? String else { return }
    if mediaType == kUTTypeMovie as String {
      guard let videoUrl = info[UIImagePickerControllerMediaURL] as? URL else { return }
      self.callback?(videoUrl.path)
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}

// MARK: - UINavigationControllerDelegate

extension MediaManager: UINavigationControllerDelegate {}
