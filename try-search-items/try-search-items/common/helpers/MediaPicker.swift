//
//  MediaPicker.swift
//  Copyright © 2017 com.watarumaeda. All rights reserved.
//

import UIKit
import MobileCoreServices

typealias ImageCallback = (_ image: UIImage) -> ()
typealias VideoCallback = (_ videoPath: URL) -> ()

// MARK: - MediaPicker

class MediaPicker: NSObject {
  
  static var shared = MediaPicker()
  private override init() {}
  
  fileprivate var videoCallback: VideoCallback?
  fileprivate var imageCallback: ImageCallback?
  
  // MARK: Photo
  
  func getFromCamera(_ viewController: UIViewController,
                     allowsEditing: Bool,
                     imageCallback: @escaping ImageCallback) {
    let picker = UIImagePickerController()
    picker.sourceType = .camera
    picker.allowsEditing = allowsEditing
    picker.delegate = self
    viewController.present(picker, animated: true, completion: nil)
    self.imageCallback = imageCallback
  }
  
  func getFromLibrary(_ viewController: UIViewController,
                      allowsEditing: Bool,
                      imageCallback: @escaping ImageCallback) {
    let picker = UIImagePickerController()
    picker.sourceType = .photoLibrary
    picker.allowsEditing = allowsEditing
    picker.delegate = self
    viewController.present(picker, animated: true, completion: nil)
    self.imageCallback = imageCallback
  }
  
  // MARK: Video
  
  func getFromCamera(_ viewController: UIViewController,
                     allowsEditing: Bool,
                     videoCallback: @escaping VideoCallback) {
    let picker = UIImagePickerController()
    picker.sourceType = .camera
    picker.cameraDevice = .rear
    picker.mediaTypes = [kUTTypeMovie as String]
    picker.cameraCaptureMode = .video
    picker.allowsEditing = allowsEditing
    picker.delegate = self
    viewController.present(picker, animated: true, completion: nil)
    self.videoCallback = videoCallback
  }
  
  func getFromLibrary(_ viewController: UIViewController,
                      allowsEditing: Bool,
                      videoCallback: @escaping VideoCallback) {
    let picker = UIImagePickerController()
    picker.sourceType = .photoLibrary
    picker.mediaTypes = [kUTTypeMovie as String]
    picker.allowsEditing = allowsEditing
    picker.delegate = self
    viewController.present(picker, animated: true, completion: nil)
    self.videoCallback = videoCallback
  }
}

// MARK: - UIImagePickerControllerDelegate

extension MediaPicker: UIImagePickerControllerDelegate {
  
  public func imagePickerController(_ picker: UIImagePickerController,
                                    didFinishPickingMediaWithInfo info: [String : Any]) {
    // Dismiss picker
    picker.dismiss(animated: true, completion: nil)
    
    // Get Media type to detect photo or video
    guard let mediaType = info[UIImagePickerControllerMediaType] as? String else { return }
    
    if mediaType == kUTTypeImage as String {
      
      // get image
      guard let image = picker.allowsEditing ?
        info[UIImagePickerControllerEditedImage] as? UIImage :
        info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
      
      imageCallback?(image)   // Image callback
      
    } else if mediaType == kUTTypeMovie as String {
      
      // return temp vid url
      guard let vidUrl = info[UIImagePickerControllerMediaURL] as? URL else { return }
      videoCallback?(vidUrl)  // vid callback
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}

// MARK: - UINavigationControllerDelegate

extension MediaPicker: UINavigationControllerDelegate {}
