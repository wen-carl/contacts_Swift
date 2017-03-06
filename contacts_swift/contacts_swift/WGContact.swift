//
//  WGContact.swift
//  contacts_swift
//
//  Created by Admin on 17/1/12.
//  Copyright © 2017年 Wind. All rights reserved.
//

import UIKit


struct dicStruct {
    var indexArr: [String] = []
    var value: [String: String] = [:]
}

class simpleModel: NSObject,NSCoding {
    
    fileprivate let key_indexArr = "m_indexArr"
    fileprivate let key_value = "m_value"
    
    var indexArr: [String]?
    var value: [String: String]?
    
    init(indexArr: [String], value: [String: String]) {
        super.init()
        self.indexArr = indexArr
        self.value = value
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        indexArr = aDecoder.decodeObject(forKey: key_indexArr) as? [String]
        value = aDecoder.decodeObject(forKey: key_value) as? [String : String]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(indexArr, forKey: key_indexArr)
        aCoder.encode(value, forKey: key_value)
    }
}

class WGContact: NSObject,NSCoding {
    
    fileprivate let key_name = "c_name"
    fileprivate let key_address = "c_address"
    fileprivate let key_image = "c_image"
    fileprivate let key_phoneNum = "c_phoneNum"
    fileprivate let key_email = "c_email"
    fileprivate let key_birthday = "c_birthday"
    
    var name: String!
    var address: String?
    var image: UIImage?
    var phoneNum: simpleModel?
    var email: simpleModel?
    var birthday: [String: Int]?
    var group: String {
        return self.name.substring(to: self.name.index(after: self.name.startIndex))
    }
    
    init(name: String) {
        super.init()
        self.name = name
        address = "xian"
        image = UIImage.init(named: "contact.png")
        phoneNum = simpleModel.init(indexArr: ["phone1","phone2","phone3"], value: ["phone1": ""])
        email = simpleModel.init(indexArr: ["email1","email2","email3"], value: ["email": ""])
        birthday = ["year": 2017, "month": 1, "day": 13]
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        name = (aDecoder.decodeObject(forKey: key_name) as? String)!
        image = aDecoder.decodeObject(forKey: key_image) as? UIImage
        address = aDecoder.decodeObject(forKey: key_address) as? String
        birthday = aDecoder.decodeObject(forKey: key_birthday) as? [String : Int]
        phoneNum = aDecoder.decodeObject(forKey: key_phoneNum) as? simpleModel
        email = aDecoder.decodeObject(forKey: key_email) as? simpleModel
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: key_name)
        aCoder.encode(image, forKey: key_image)
        aCoder.encode(address, forKey: key_address)
        aCoder.encode(birthday, forKey: key_birthday)
        aCoder.encode(phoneNum, forKey: key_phoneNum)
        aCoder.encode(email, forKey: key_email)
    }
    
    // MARK: Get Data
    
    class func loadData() -> [String: WGContactGroup] {
        var contacts: [String: WGContactGroup] = [:]
        
        if NSKeyedUnarchiver.unarchiveObject(withFile: getContactsPath()) != nil {
            contacts = NSKeyedUnarchiver.unarchiveObject(withFile: getContactsPath()) as! [String : WGContactGroup]
        }
        
        return contacts
    }
    
    class func getContactsPath() -> String {
        let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return path + "/contacts.plist"
    }
    
    // MARK: Save Data
    
    class func save(contact: WGContact, replacedContact: WGContact?, index: Int) -> Bool {
        var contacts: [String: WGContactGroup]? = loadData()
        
        if replacedContact != nil {
            let oldGroup = contacts?[(replacedContact?.group)!]
            oldGroup?.contacts?.remove(at: index)
        }
        
        var group: WGContactGroup? = contacts?[contact.group]
        if group != nil {
            group?.contacts?.append(contact)
            group?.contacts = group?.contacts?.sorted(by: { (contact1, contact2) -> Bool in
                return contact1.name < contact2.name
            })
        } else {
            group = WGContactGroup.init(name: contact.group)
            group?.contacts?.append(contact)
        }
        contacts?[(group?.name)!] = group
        
        return saveData(contacts!)
    }
    
    class func saveData(_ contacts: [String: WGContactGroup]) -> Bool {
        return NSKeyedArchiver.archiveRootObject(contacts, toFile: getContactsPath())
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
