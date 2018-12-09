//
//  ViewController.swift
//  try-search-items
//
//  Created by Wataru Maeda on 2018-12-08.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var all = [String]()
    fileprivate var selected = [String]()
    fileprivate var recommends = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Items"
    }
    
    func initVariables() {
        all = [
            "a", "b", "c", "d", "e", "f", "g", "h", "i", "j"
        ]
        
        recommends = [
            "k", "l", "m", "n"
        ]
    }
}

