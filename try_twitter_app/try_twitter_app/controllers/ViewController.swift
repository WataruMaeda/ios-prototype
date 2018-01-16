//
//  ViewController.swift
//  try_twitter_app
//
//  Created by Wataru Maeda on 2017/12/13.
//  Copyright © 2017 com.watarumaeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let cellId = "cellId"
  
  private lazy var tableHeaderView: TableHeaderView = {
    let headerView = TableHeaderView()
    headerView.frame = CGRect(x: 0, y: 0, width: view.viewWidth, height: view.viewWidth * 0.4)
    return headerView
  }()
  
  fileprivate lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.tableHeaderView = tableHeaderView
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    tableView.dataSource = self
    tableView.delegate = self
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupTable()
  }
}

// MARK: - UIScrollView

extension ViewController {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print(tableView.contentOffset.y)
    tableHeaderView.updateHeaderContentsSize(currentOffsetY: scrollView.contentOffset.y)
  }
}

// MARK: - UITableView

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  fileprivate func setupTable() {
    view.addSubview(tableView)
    tableView.fillAnchor()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) else { return UITableViewCell() }
    cell.backgroundColor = .white
    cell.textLabel?.text = "TEST TEST TEST"
    cell.textLabel?.textColor = .flatDarkGray
    return cell
  }
}
