//
//  WGContactViewController.swift
//  contacts_swift
//
//  Created by Admin on 17/1/12.
//  Copyright © 2017年 Wind. All rights reserved.
//

import UIKit

class WGContactViewController: UIViewController,WGContactsViewDelegate {

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
        
        let contactsView = WGContactsView.init(frame: rect)
        contactsView.delegate = self
        self.view.addSubview(contactsView)
        
    }
    
    //////////////////////////////////////////////////////
    // WGContactsView Delegate                          //
    //////////////////////////////////////////////////////
    
    func contactsView(_ contactsView: WGContactsView, didSelect contact: WGContact, and index: Int) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
