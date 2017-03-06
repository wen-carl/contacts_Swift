//
//  WGTableViewCell.swift
//  contacts_swift
//
//  Created by Admin on 17/2/7.
//  Copyright © 2017年 Wind. All rights reserved.
//

import UIKit

enum WGTableViewCellStyle {
    case none
    case add
    case delete
}

//@objc protocol WGTableviewCellDelegate {
//    @objc optional func didChangeData(cell: WGTableViewCell, isAdd: Bool)
//}

protocol WGTableviewCellDelegate {
    func didChangeData(cell: WGTableViewCell, isAdd: Bool)
}

class WGTableViewCell: UITableViewCell {
    
    lazy var kindTextField: UITextField = {
        weak var weakSelf = self
        let tf = UITextField.init(frame: CGRect.init(x: 0, y: 0, width: 120, height: self.frame.size.height))
        tf.textAlignment = NSTextAlignment.right
        tf.textColor = UIColor.darkGray
        tf.tag = 1000
        
        return tf
    }()
    lazy var infoTextField: UITextField = {
        weak var weakSelf = self
        let tf = UITextField.init(frame: CGRect.init(x: 125, y: 0, width: self.frame.size.width - 100, height: self.frame.size.height))
        tf.textAlignment = .left
        tf.textColor = .darkGray
        tf.tag = 1001
        
        return tf
    }()
    lazy var button: UIButton = {
        weak var weakSelf = self
        let btn = UIButton.init(type: .system)
        btn.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 15
        
        return btn
    }()
    var bEditing: Bool = false {
        didSet {
            setEditting(edit: bEditing)
        }
    }
    var style: WGTableViewCellStyle?
    var delegate: WGTableviewCellDelegate?
    
    
    init(style: WGTableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.style = style
        self.contentView.addSubview(kindTextField)
        self.contentView.addSubview(infoTextField)
        
        if style != WGTableViewCellStyle.none {
            switch style {
            case .add:
                button.backgroundColor = .green
                button.setTitle("+", for: .normal)
            case .delete:
                button.backgroundColor = .red
                button.setTitle("-", for: .normal)
            default:
                break
            }
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(onDataChange(_ :)), for: .touchUpInside)
            self.accessoryView = button
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setEditting(edit: Bool) -> Void {
        kindTextField.isEnabled = edit
        kindTextField.borderStyle = edit ? .line : .none
        
        infoTextField.isEnabled = edit
        infoTextField.borderStyle = edit ? .line : .none
        
        self.accessoryView?.isHidden = edit
    }
    
    func onDataChange(_ btn: UIButton) -> Void {
        var bAdd: Bool = false
        switch style! {
        case .add:
            bAdd = true
        case .delete :
            bAdd = false
        //case .none:
            //break
        default:
            break
        }
        
        delegate?.didChangeData(cell: self, isAdd: bAdd)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}












