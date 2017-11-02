//
//  Service.swift
//  try_flicker
//
//  Created by Wataru Maeda on 2017/11/02.
//  Copyright © 2017 Wataru Maeda. All rights reserved.
//

import UIKit
import Alamofire

class Service: NSObject {
  static var shared = Service()
  private override init() {}
  
  let host = "https://api.flickr.com/services/rest/?"
  let format = "&format=json&nojsoncallback=1"
  let api_key = "&api_key=c2a8d58e662273445a57245c951760d3"
  
  func getRecentPhotos(completion:
    @escaping (_ success: Bool,_ result: [[String:Any]]) -> Void) {
    let method = "method=flickr.photos.getRecent"
    Alamofire.request(
      host + method + format + api_key + "&extras=url_o")
      .responseJSON { response in
        guard let resut = response.result.value as? [String: Any],
              let photos = resut["photos"] as? [String: Any],
              let photo = photos["photo"] as? [[String:Any]]
          else { return completion(false, [[:]]) }
        completion(true, photo)
    }
  }
  
  func searchPhotos(_ text: String, completion:
    @escaping (_ success: Bool,_ result: [[String:Any]]) -> Void) {
    let method = "method=flickr.photos.search"
    Alamofire.request(
      host + method + format + api_key + "&tags=\(text)&extras=url_o")
      .responseJSON { response in
        guard let resut = response.result.value as? [String: Any],
          let photos = resut["photos"] as? [String: Any],
          let photo = photos["photo"] as? [[String:Any]]
          else { return completion(false, [[:]]) }
        completion(true, photo)
    }
  }
}
