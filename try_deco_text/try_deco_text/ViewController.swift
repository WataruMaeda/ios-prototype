//
//  ViewController.swift
//  try_deco_text
//
//  Created by Wataru Maeda on 2018-05-22.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var label: UILabel! {
    didSet {
      label.frame = UIScreen.main.bounds
      label.text = "1111<em>2222<em>3333<em>4444<em>"
      label.font = UIFont.systemFont(ofSize: 20)
      label.textAlignment = .center
      label.numberOfLines = 0
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    label = UILabel()
    label.decoText("011112222<em>3333<em>4444ddddd")
    view.addSubview(label)
  }
}

extension UILabel {
  
  func decoText(_ text: String, color: UIColor) {
    
    // devide by tag
    var texts = text.components(separatedBy: "<em>")
    
    // if the open/close tag is incollect
    if texts.count < 3 {
      self.text = text.replacingOccurrences(of: "<em>", with: "")
      return;
    }
    
    // remove first/last element
    texts.removeFirst()
    texts.removeLast()
    
    // remove tags
    let decoText = text.replacingOccurrences(of: "<em>", with: "")
    
    // create attribute text
    let attrText = NSMutableAttributedString(string: decoText)
    for txt in texts {
      if let range = decoText.range(of: txt) {
        let nsRange = decoText.nsRange(from: range)
        attrText.addAttribute(.backgroundColor, value: UIColor.yellow, range: nsRange)
      }
    }
    attributedText = attrText
  }
}

private extension StringProtocol where Index == String.Index {
  func nsRange(from range: Range<Index>) -> NSRange {
    return NSRange(range, in: self)
  }
}
