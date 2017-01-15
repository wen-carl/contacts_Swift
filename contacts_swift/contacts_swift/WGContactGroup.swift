//
//  WGContactGroup.swift
//  contacts_swift
//
//  Created by Admin on 17/1/12.
//  Copyright © 2017年 Wind. All rights reserved.
//

import UIKit

class WGContactGroup: NSObject,NSCoding {
    
    let key_name = "cg_name"
    let key_contacts = "cg_contacts"
    
    var name: String!
    var contacts: [WGContact]?
    
    init(name: String) {
        super.init()
        self.name = name
        contacts = []
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        name = aDecoder.decodeObject(forKey: key_name) as! String!
        contacts = aDecoder.decodeObject(forKey: key_contacts) as! [WGContact]?
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: key_name)
        aCoder.encode(contacts, forKey: key_contacts)
    }
    
    
    
    
    

}
