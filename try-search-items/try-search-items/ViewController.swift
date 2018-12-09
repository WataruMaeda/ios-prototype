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
    fileprivate var remains = [String]()
    fileprivate var isSearching = false
    
    let cellId = "cellId"
    
    fileprivate lazy var searchbar: UISearchBar = {
        let search = UISearchBar()
        search.delegate = self
        search.showsScopeBar = true
        search.placeholder = "Search items"
        return search
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
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
        all = [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n" ]
        recommends = [ "k", "l", "m", "n" ]
        remains = [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j" ]
    }
}

// MARK : - UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    
    func setupSearchBar() {
        view.addSubview(searchbar)
        searchbar.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.showsCancelButton = false
        self.view.endEditing(true)
        searchBar.text = ""
        tableView.reloadData(with: .automatic)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        tableView.reloadData(with: .automatic)
        isSearching = true
        searchBar.showsCancelButton = true
        tableView.reloadData(with: .automatic)
        return true
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func setupTable() {
        view.addSubview(tableView)
        tableView.anchor(searchbar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching { return all.count }
        if selected.count == 0 { return section == 0 ? recommends.count : remains.count }
        return section == 0 ? selected.count : remains.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isSearching ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching { return "All items" }
        if selected.count == 0 { return section == 0 ? "Recommends" : "All items" }
        return section == 0 ? "Selected Items" :  "All items"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? TableViewCell else {
            return UITableViewCell()
        }
        if isSearching {
            cell.label.text = all[indexPath.row]
        } else if (selected.count == 0) {
            cell.label.text = indexPath.section == 0
                ? recommends[indexPath.row]
                : remains[indexPath.row]
        } else {
            cell.label.text = indexPath.section == 0
                ? selected[indexPath.row]
                : remains[indexPath.row]
        }
        return cell
    }
}

// MARK: - TableViewCell

class TableViewCell: UITableViewCell {
    
    lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "check")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubviews() {
        addSubview(label)
        addSubview(imgView)
        
        label.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 0)
        
        imgView.anchor(topAnchor, left: label.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 5, rightConstant: 16, widthConstant: 50, heightConstant: 0)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
}

// MARK: - extension

extension UITableView {
    func reloadData(with animation: UITableView.RowAnimation) {
        beginUpdates()
        reloadSections(IndexSet(integersIn: 0..<numberOfSections), with: animation)
        endUpdates()
    }
}
