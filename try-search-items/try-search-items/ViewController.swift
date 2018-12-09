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
    
    let cellId = "cellId"
    
    fileprivate lazy var searchbar: UISearchBar = {
        let search = UISearchBar()
        search.delegate = self
        search.showsScopeBar = true
        return search
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Items"
        setup()
        setupSearchBar()
        setupTable()
    }
    
    func setup() {
        edgesForExtendedLayout = []
        all = [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j" ]
        recommends = [ "k", "l", "m", "n" ]
    }
}

// MARK : - UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    
    func setupSearchBar() {
        view.addSubview(searchbar)
        searchbar.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func setupTable() {
        view.addSubview(tableView)
        tableView.anchor(searchbar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) else { return UITableViewCell() }
        cell.backgroundColor = .red
        return cell
    }
}
