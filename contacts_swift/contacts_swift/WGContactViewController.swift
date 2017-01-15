//
//  WGContactViewController.swift
//  contacts_swift
//
//  Created by Admin on 17/1/12.
//  Copyright © 2017年 Wind. All rights reserved.
//

import UIKit

class WGContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "contacts"
        let contactsView = WGContactsView.init(frame: UIScreen.main.bounds)
        self.view.addSubview(contactsView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
