//
//  EmbededViewController.swift
//  try_scroll_embed
//
//  Created by Wataru Maeda on 2018/01/23.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class EmbededViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

  lazy var tableView: UITableView = {
    let tableView = UITableView(frame: view.bounds, style: .plain)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.delegate = self
    tableView.dataSource = self
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(tableView)
    tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 30
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = "TEST TEST TEST"
    return cell
  }
}
