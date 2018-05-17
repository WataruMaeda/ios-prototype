//
//  OcrService.swift
//  try_ocr
//
//  Created by Wataru Maeda on 2018-05-16.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit
import Alamofire

let url = "https://vision.googleapis.com/v1/images:annotate?key={APIKey}"

class OcrService: NSObject {

  static func detectText(fromImage: UIImage) {
    
    // get params for post request
    guard let params = getOcrParams(fromImage) else { return };
    
    // post request
    Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (response) in
      switch response.result {
      case .success:
        print(response.result.value)
        
      case .failure(let error):
        print(error)
      }
    }
    
  }
}

fileprivate extension OcrService {
  
  static func getOcrParams(_ image: UIImage) -> [String: Any]? {
    guard let base64Image = getBase65Image(image) else {
      return nil
    }
    return [
      "requests": [
        "image": ["content": base64Image],
        "features": ["type": "TEXT_DETECTION"]
      ]
    ]
  }
  
  private static func getBase65Image(_ image: UIImage) -> String? {
    guard let pngImage = UIImagePNGRepresentation(image) else { return nil }
    return pngImage.base64EncodedString(options: .lineLength64Characters)
  }
}
