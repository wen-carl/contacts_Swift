//
//  WGContact.swift
//  contacts_swift
//
//  Created by Admin on 17/1/12.
//  Copyright © 2017年 Wind. All rights reserved.
//

import UIKit

struct birthdayStruct {
    var year: Int = 2017
    var month: Int = 1
    var day: Int = 13
}

struct dicStruct {
    var indexArr: [String] = []
    var value: [String: String] = [:]
}

class WGContact: NSObject {
    
    var name: String!
    var address: String?
    var image: UIImage?
    var phoneNum: dicStruct = dicStruct()
    var email: dicStruct = dicStruct()
    var birthday: birthdayStruct = birthdayStruct()
    var group: String {
        return self.getGroupName()
    }
    
    func getGroupName() -> String {
        return self.name.substring(to: self.name.startIndex)
    }
    
    init(name: String) {
        super.init()
        self.name = name
        self.image = UIImage.init(named: "contact.png")
        self.phoneNum.indexArr = ["phone1","phone2","phone3"]
        self.phoneNum.value[self.phoneNum.indexArr[0]] = ""
        self.email.indexArr = ["email1","email2"]
        self.email.value[self.email.indexArr[0]] = ""
    }
    
    init(coder aDecoder: NSCoder!) {
        self.name = (aDecoder.decodeObject(forKey: "name") as? String)!
        self.image = aDecoder.decodeObject(forKey: "image") as? UIImage
        self.address = aDecoder.decodeObject(forKey: "address") as? String
        self.birthday = (aDecoder.decodeObject(forKey: "birthday") as? birthdayStruct)!
        self.phoneNum = (aDecoder.decodeObject(forKey: "phoneNum") as? dicStruct)!
        self.email = (aDecoder.decodeObject(forKey: "email") as? dicStruct)!
    }
    
    func encode(aCoder: NSCoder!) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(birthday, forKey: "birthday")
        aCoder.encode(phoneNum, forKey: "phoneNum")
        aCoder.encode(email, forKey: "email")
    }
    
    class func getContactsPath() -> String {
        let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return path + "/contacts.plist"
    }
    
    class func saveData(contacts: [String: [WGContactGroup]]) -> Bool {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(contacts, forKey: "key_contacts")
        archiver.finishEncoding()
        return data.write(toFile: getContactsPath(), atomically: true)
    }
    
    class func loadData() -> [String: [WGContactGroup]] {
        let fileManager = FileManager()
        var contacts: [String: [WGContactGroup]] = [:]
        
        if fileManager.fileExists(atPath: getContactsPath()) {
            let url = URL.init(string: getContactsPath())
            let data = try! Data(contentsOf: url!)
            
            let unArchiver = NSKeyedUnarchiver(forReadingWith: data)
            contacts = unArchiver.decodeObject(forKey: "key_contacts") as! [String : [WGContactGroup]]
            unArchiver.finishDecoding()
        }
        
        return contacts
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
