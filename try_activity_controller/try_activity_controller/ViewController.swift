//
//  ViewController.swift
//  try_activity_controller
//
//  Created by Wataru Maeda on 2019-02-09.
//  Copyright © 2019 com.watarumaeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNaviMenu()
    }
    
    func setupNaviMenu() {
        let shareButton = UIButton(type: .custom)
        shareButton.setImage(UIImage(named: "share"), for: .normal)
        shareButton.imageView?.contentMode = .scaleAspectFit
        shareButton.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        shareButton.addTarget(self, action: #selector(tappedShare), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
    }
    
    @objc func tappedShare() {
        var items = [Any]()
        if let url = URL(string: "https://www.apple.com") {
            items.append(url)
        } else {
            items.append("https://www.apple.com")
        }
        let activityController = UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )
        present(activityController, animated: true)
    }
}

