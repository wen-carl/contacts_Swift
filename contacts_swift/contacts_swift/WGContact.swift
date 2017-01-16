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
        return self.getGroupName()
    }
    
    func getGroupName() -> String {
        return self.name.substring(to: self.name.startIndex)
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
    
    class func getContactsPath() -> String {
        let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return path + "/contacts.plist"
    }
    
    class func saveData(_ contacts: [String: WGContactGroup]) -> Bool {
//        let data = NSMutableData()
//        let archiver = NSKeyedArchiver(forWritingWith: data)
//        archiver.encode(contacts, forKey: "key_contacts")
//        archiver.finishEncoding()
//        return data.write(toFile: getContactsPath(), atomically: true)
        
        return NSKeyedArchiver.archiveRootObject(contacts, toFile: getContactsPath())
    }
    
    class func loadData() -> [String: WGContactGroup] {
        //let fileManager = FileManager()
        var contacts: [String: WGContactGroup] = [:]
        
        if NSKeyedUnarchiver.unarchiveObject(withFile: getContactsPath()) != nil {
            contacts = NSKeyedUnarchiver.unarchiveObject(withFile: getContactsPath()) as! [String : WGContactGroup]
        }
        
//        if fileManager.fileExists(atPath: getContactsPath()) {
//            let url = URL.init(string: getContactsPath())
//            let data = try! Data.init(contentsOf: url!, options: Data.ReadingOptions.alwaysMapped)
//            
//            let unArchiver = NSKeyedUnarchiver(forReadingWith: data)
//            contacts = unArchiver.decodeObject(forKey: "key_contacts") as! [String : WGContactGroup]
//            unArchiver.finishDecoding()
//        }
        
        return contacts
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
