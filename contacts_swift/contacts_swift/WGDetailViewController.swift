//
//  WGDetailViewController.swift
//  contacts_swift
//
//  Created by Admin on 17/1/12.
//  Copyright © 2017年 Wind. All rights reserved.
//

import UIKit

class WGDetailViewController: UIViewController {
    
    var contact: WGContact?
    var index: Int?
    var detailView: WGContactDetailView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = (contact != nil) ? contact!.name : "Add New Contact";
        
        let statusFrame = UIApplication.shared.statusBarFrame
        let navBarFrame = self.navigationController?.navigationBar.frame
        let originY = statusFrame.size.height + (navBarFrame?.size.height)!
        let rect = CGRect.init(x: 0, y: originY, width: self.view.frame.size.width, height: self.view.frame.size.height - originY)
        detailView = WGContactDetailView.init(frame: rect, and: contact)
        self.view.addSubview(detailView!)
        
        var bar = self.navigationItem.rightBarButtonItem
        if bar == nil {
            bar = UIBarButtonItem.init(barButtonSystemItem: ((contact == nil) ? UIBarButtonSystemItem.save : UIBarButtonSystemItem.edit), target: self, action: #selector(onEditOrDone(_:)))
        } else {
            bar?.title = ((contact == nil) ? "Save" : "Edit")
        }
    }
    
    func onEditOrDone(_ bar: UIBarButtonItem) -> Void {
        let title: Bool = bar.title == "Edit"
        if title {
            bar.title = "Done"
        } else {
            bar.title = "Edit"
        }
    }
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}










