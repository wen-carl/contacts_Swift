//
//  WGContactViewController.swift
//  contacts_swift
//
//  Created by Admin on 17/1/12.
//  Copyright © 2017年 Wind. All rights reserved.
//

import UIKit

class WGContactViewController: UIViewController,WGContactsViewDelegate {
    
    var contactsView: WGContactsView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "contacts"
        self.view.backgroundColor = UIColor.white
        
        let H = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.size.height)!
        print("H:\(H)")
        
        var rect = UIScreen.main.bounds
        rect.origin.y += H
        rect.size.height -= H
        print("RECT:\(rect)")
        
        contactsView = WGContactsView.init(frame: rect)
        contactsView?.delegate = self
        self.view.addSubview(contactsView!)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(onAddContact(_:)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: NSNotification.Name.init("WGContactDidFinishEditting"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init("WGContactDidFinishEditting"), object: nil)
    }
    
    func onAddContact(_ bar: UIBarButtonItem) -> Void {
        let detailVC = WGDetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func refreshData() -> Void {
        contactsView?.setUpData()
        contactsView?.tableView?.reloadData()
    }
    
    // MARK: WGContactsView Delegate
    
    func contactsView(_ contactsView: WGContactsView, didSelect contact: WGContact, and index: Int) {
        let detailVC = WGDetailViewController()
        detailVC.index = index
        detailVC.contact = contact
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}







