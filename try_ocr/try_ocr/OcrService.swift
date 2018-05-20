//
//  OcrService.swift
//  try_ocr
//
//  Created by Wataru Maeda on 2018-05-16.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit
import Alamofire

let url = "https://vision.googleapis.com/v1/images:annotate?key={API-KEY}

class OcrService: NSObject {

  static func detectTexts(from: UIImage, callback: @escaping ([String]?) -> Void) {
    
    // get params for request
    guard let params = getOcrParams(from) else { return };
    
    // post request
    Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (response) in
      switch response.result {
        
      case .success:
        let texts = extractTexts(from: response);
        texts.count > 0 ? callback(texts) : callback(nil)
        
      case .failure(let error):
        print(error)
        callback(nil)
      }
    }
  }
}

// MARK: - Parser

fileprivate extension OcrService {
  
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

// MARK: - Supporting Functions

fileprivate extension OcrService {
  
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
