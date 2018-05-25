//
//  OcrService.swift
//  try_ocr
//
//  Created by Wataru Maeda on 2018-05-16.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit
import Alamofire
import TesseractOCR

class OcrService: NSObject {

  static func detectTexts(_ viewController: UIViewController,
                          from: UIImage,
                          callback: @escaping (String?) -> Void) {
    
    // get texts from Vision API
    extractTextsWithVisionApi(from: from) { (textFromVision) in
      
      // if Vision API detext texts
      if (textFromVision != nil) {
        return callback(textFromVision)
      }
      
      // if Vision API cannot detext texts, select language
      UIAlertController.showLanguage(viewController, callback: { (language) in
        
        // get texts from Tesseract OCR
        let textFromTesseract = extractTextsWithTesseract(from, language: language)
        
        // if Vision API detext texts
        if (textFromTesseract != nil) {
          return callback(textFromTesseract)
        }
        
        // no result
        callback(nil)
      })
    }
  }
}

// MARK: - Vision API

let url = "https://vision.googleapis.com/v1/images:annotate?key={API-KEY}"

fileprivate extension OcrService {
  
  static func extractTextsWithVisionApi(from: UIImage, callback: @escaping (String?) -> Void) {
    
    // get params for request
    guard let params = getOcrParams(from) else { return };
    
    // post request
    Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (response) in
      switch response.result {
        
      case .success:
        let texts = extractTexts(from: response);
        texts.count > 0 ? callback(appendTexts(from: texts)) : callback(nil)
        
      case .failure(let error):
        print(error)
        callback(nil)
      }
    }
    
  }
  
  static func extractTexts(from: DataResponse<Any>) -> [String] {
    var texts = [String]()
    
    // check response data
    guard let value = from.result.value as? [String: Any],
          let responses = value["responses"] as? [[String: Any]] else { return texts }
    
    // extract texts from response
    for response in responses {
      if let textAnnotations = response["textAnnotations"] as? [[String: Any]] {
        if let textAnnotation = textAnnotations.first {
          if let description = textAnnotation["description"] as? String {
            texts.append(description)
          }
        }
      }
    }
    
    return texts
  }
}

// MARK: - TesseractOCR

fileprivate extension OcrService {
  
  static func extractTextsWithTesseract(_ from: UIImage, language: String) -> String? {
    
    let tesseract = G8Tesseract(language: language)
    tesseract?.image = from
    tesseract?.recognize()
    
    guard let blocks = tesseract?.recognizedBlocks(by: G8PageIteratorLevel.symbol) else { return nil }
    
    var text = ""
    for block in blocks {
      if let g8Block = block as? G8RecognizedBlock {
        text += g8Block.text
      }
    }
    
    return text.count > 0 ? text : nil
  }
}


// MARK: - Supporting Functions

fileprivate extension OcrService {
  
  static func appendTexts(from: [String]) -> String {
    var text = ""
    from.forEach({ text += $0 })
    return text
  }
  
  static func getOcrParams(_ image: UIImage) -> [String: Any]? {
    guard let base64Image = convertToBase64(image) else {
      return nil
    }
    return [
      "requests": [
        "image": ["content": base64Image],
        "features": ["type": "TEXT_DETECTION"]
      ]
    ]
  }
  
  private static func convertToBase64(_ image: UIImage) -> String? {
    guard let pngImage = UIImagePNGRepresentation(image) else { return nil }
    return pngImage.base64EncodedString(options: .lineLength64Characters)
  }
}
