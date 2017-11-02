//
//  Photo.swift
//  try_flicker
//
//  Created by Wataru Maeda on 2017/11/02.
//  Copyright © 2017 Wataru Maeda. All rights reserved.
//

import UIKit

class Photo: NSObject {
  var title = ""
  var url_o = ""
  
  class func createFromJsons(dics: [[String: Any]]) -> [Photo]{
    var ps = [Photo]()
    for dic in dics {
      if let p = createFromJson(dic: dic) {
        ps.append(p)
      }
    }
    return ps
  }
  
  private class func createFromJson(dic: [String: Any]) -> Photo? {
    guard let title = dic["title"] as? String,
          let url_o = dic["url_o"] as? String
      else { return nil }
    let p = Photo()
    p.title = title
    p.url_o = url_o
    return p
  }
}
