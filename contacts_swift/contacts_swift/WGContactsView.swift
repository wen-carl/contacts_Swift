//
//  WGContactsView.swift
//  contacts_swift
//
//  Created by Admin on 17/1/13.
//  Copyright © 2017年 Wind. All rights reserved.
//

import UIKit

class WGContactsView: UIView, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var allContacts: [String: [WGContactGroup]]?
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var resultArr: [WGContact]?
    var isSearching: Bool?
    var indexArr: [String] {
        return [String](allContacts!.keys)
    }
    
    func setUpData() {
        
        allContacts = WGContact.loadData()
        
        if allContacts?.count == 0 {
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpData()
        
        isSearching = false
        searchBar = UISearchBar.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: 50))
        searchBar.delegate = self
        self.addSubview(searchBar)
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 50, width: frame.size.width, height: frame.size.height - 50), style: UITableViewStyle.grouped)
        tableView.dataSource = self
        tableView.delegate = self
        self.addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "---")!
        return cell
    }





}
