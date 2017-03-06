//
//  WGContactDetailView.swift
//  contacts_swift
//
//  Created by Admin on 17/2/7.
//  Copyright © 2017年 Wind. All rights reserved.
//

import UIKit

protocol WGContactDetailViewDelegate: NSObjectProtocol {
    func didChangesInfo(detailView: WGContactDetailView, showInfo: Bool)
}

class WGContactDetailView: UIView ,WGHeaderViewDelegate, WGTableviewCellDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var contact: WGContact?
    var delegate: WGContactDetailViewDelegate?
    lazy var tableView: UITableView = {
        weak var weakSelf = self
        let table = UITableView.init(frame: CGRect.init(x: 0, y: 210, width: weakSelf!.frame.size.width, height: weakSelf!.frame.size.height - 260), style: .grouped)
        
        return table
    }()
    var headerView: WGHeaderView?
    var tableHeader: WGTableHeader?
    var isEditing: Bool = false {
        didSet {
            
        }
    }
    var isShowInfo: Bool = true {
        didSet {
            
        }
    }
    
    
    init(frame: CGRect, and oneContact: WGContact?){
        super.init(frame: frame)
        self.contact = oneContact
        isShowInfo = true;
        
        if contact == nil {
            isEditing = true
            contact = WGContact.init(name: "")
        } else {
            isEditing = false
        }
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: .UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        let center = NotificationCenter.default
        center.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        center.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    // MARK: Notification Methods
    
    func keyboardWillShow(_ noti: NSNotification) -> Void {
        let dic = noti.userInfo
        let value = dic?[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let height = value.cgRectValue.size.height
        print("height1:\(height)")
        
        var rect = tableView.frame
        rect.size.height -= height
        tableView.frame = rect;
    }
    
    func keyboardWillHide(_ noti: NSNotification) -> Void {
        let dic = noti.userInfo
        let value = dic?[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let height = value.cgRectValue.size.height
        print("height2:\(height)")
        
        var rect = tableView.frame
        rect.size.height += height
        tableView.frame = rect
    }
    
    // MARK: WGHeaderView Delegate
    
    func present(imagePicker: UIImagePickerController) {
        if delegate!.isKind(of: UIViewController.self) {
        }
    }
    
    func didFinishPicking(imagePicker: UIImagePickerController, image: UIImage) {
        contact?.image = image
    }
    
    // MARK: WGTableViewCellDelegate
    
    func didChangeData(cell: WGTableViewCell, isAdd: Bool) {
        
    }
    
    // MARK: UITableView DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WGTableViewCell.init(style: .none, reuseIdentifier: "")
        
        return cell
    }
    
    // MARK: UITableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    // MARK: UIPickerView Dataource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    // MARK: UIPickerView Delegate
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        return UILabel.init(frame: CGRect.zero)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
}














