//
//  ViewControllerA.swift
//  sample-tab-pageMenu
//
//  Created by Wataru Maeda on 2019-01-19.
//  Copyright © 2019 com.watarumaeda. All rights reserved.
//

import UIKit

let cellId = "cellId"

class ViewControllerA: UIViewController {
  
  var callback: () -> Void = {}
  
  fileprivate lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
    tableView.dataSource = self
    tableView.delegate = self
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.frame = view.frame
    view.addSubview(tableView)
  }
  
  func addSelectedHandler(callback: @escaping () -> Void = {}) {
    self.callback = callback
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewControllerA: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? TableViewCell else {
      return UITableViewCell()
    }
    cell.textLabel?.text = "セル-\(indexPath.row)"
    cell.addSelectedHandler {
      self.callback()
    }
    return cell
  }
}

// MARK: - TableViewCell

class TableViewCell: UITableViewCell {
  
  private var callback: () -> Void = {}
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func addSelectedHandler(callback: @escaping () -> Void = {}) {
    self.callback = callback
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    if selected { callback() }
  }
}

