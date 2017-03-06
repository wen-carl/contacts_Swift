//
//  WGHeaderView.swift
//  contacts_swift
//
//  Created by Admin on 17/2/7.
//  Copyright © 2017年 Wind. All rights reserved.
//

import UIKit

protocol WGHeaderViewDelegate {
    func present(imagePicker: UIImagePickerController) -> Void
    func didFinishPicking(imagePicker: UIImagePickerController, image: UIImage) -> Void
}

class WGHeaderView: UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var contact: WGContact? {
        didSet {
            imageView.image = contact?.image
            nameTF.text = contact?.name
        }
    }
    var delegate: WGHeaderViewDelegate? {
        didSet {
            nameTF.delegate = delegate as! UITextFieldDelegate?
        }
    }
    lazy var imageView: UIImageView = {
        weak var weakSelf = self
        let iv = UIImageView.init(frame: CGRect.init(x: 30, y: 10, width: 140, height: 140))
        iv.layer.masksToBounds = true
        iv.layer.borderColor = UIColor.gray.cgColor
        iv.layer.borderWidth = 1.0
        iv.layer.cornerRadius = 70
        
        let singleTap = UITapGestureRecognizer.init(target: weakSelf, action: #selector(onChooseImage(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        iv.addGestureRecognizer(singleTap)
        
        return iv
    }()
    lazy var nameTF: UITextField = {
        weak var weakSelf = self
        let tf = UITextField.init(frame: CGRect.init(x: weakSelf!.frame.size.width / 2, y: weakSelf!.imageView.center.y - 20, width: weakSelf!.frame.size.width / 3, height: 40))
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.clearButtonMode = .whileEditing
        
        return tf
    }()
    lazy var lable: UILabel = {
        weak var weakSelf = self
        let lab = UILabel.init(frame: CGRect.init(x: weakSelf!.frame.size.width / 2, y: weakSelf!.imageView.center.y - 60, width: weakSelf!.frame.size.width / 3, height: 40))
        lab.text = "Name:"
        
        return lab
    }()
    var bEditing: Bool = false {
        didSet {
            setbEditing(edit: bEditing)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        self.addSubview(lable)
        self.addSubview(nameTF)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setbEditing(edit: Bool) -> Void {
        imageView.isUserInteractionEnabled = edit
        nameTF.isEnabled = edit
        nameTF.borderStyle = edit ? .line : .none
        lable.isHidden = !edit
    }
    
    // MARK: UITapGestureRecognizer Method
    
    func onChooseImage(_ tap: UITapGestureRecognizer) -> Void {
        let imagePicker = UIImagePickerController.init()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            delegate?.present(imagePicker: imagePicker)
        }
    }
    
    // MARK: UIImagePickerController Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageView.image = image
        delegate?.didFinishPicking(imagePicker: picker, image: image)
        picker.dismiss(animated: true, completion: nil)
    }
    
}
