//
//  WGContactsView.swift
//  contacts_swift
//
//  Created by Admin on 17/1/13.
//  Copyright © 2017年 Wind. All rights reserved.
//

import UIKit

class WGContactsView: UIView, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var allContacts: [String: WGContactGroup]?
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var resultArr: [WGContact]?
    var isSearching: Bool?
    var indexArr: [String] {
        //return allContacts?.keys.sorted(by: { (key1: String, key2: String) -> Bool in
        //    return key1.compare(key2)
        //})
        
        return (allContacts?.keys.sorted())!
    }
    
    func makeData() {
        let source: [String] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9"];
        var groups: [String: WGContactGroup] = [:]
        let end = Int(arc4random() % 3 + 3)
        for _ in 0...end {
            let x = Int(arc4random() % 36)
            var first = source[x]
            while groups.keys.contains(first) {
                first = source[Int(arc4random() % 36)]
            }
            
            let group = WGContactGroup.init(name: first)
            for _ in 0...arc4random() % 5 + 3 {
                let name = first + source[Int(arc4random() % 36)] + source[Int(arc4random() % 36)] + source[Int(arc4random() % 36)]
                let contact = WGContact.init(name: name)
                contact.phoneNum?.value = [(contact.phoneNum?.indexArr?[0])!: getPhoneNumber(), (contact.phoneNum?.indexArr?[1])!: getPhoneNumber(), (contact.phoneNum?.indexArr?[2])!: getPhoneNumber()]
                contact.email?.value = [(contact.email?.indexArr?[0])!: "111@qq.com", (contact.email?.indexArr?[1])!: "110@qq.com"]
                group.contacts?.append(contact)
            }
            groups[first] = group
        }
        
        let _ = WGContact.saveData(contacts: groups)
    }
    
    func getPhoneNumber() -> String {
        let second = ["3", "5", "7", "8", "9"]
        var numbers: String = ""
        for _ in 0...9 {
            let number = arc4random() % 10
            numbers += "\(number)"
        }
        
        return "1" + second[Int(arc4random() % 5)] + numbers
    }
    
    func setUpData() {
        
        allContacts = WGContact.loadData()
        
        if allContacts?.count == 0 {
            makeData()
            setUpData()
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
        return indexArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = indexArr[section]
        return (allContacts![key]?.contacts?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "---")!
        
//        if cell == nil {
//            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "---")
//        }
        let cell: UITableViewCell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        
        
        
        return cell
    }





}
