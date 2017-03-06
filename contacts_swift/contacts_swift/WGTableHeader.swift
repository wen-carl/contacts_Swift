//
//  WGTableHeader.swift
//  contacts_swift
//
//  Created by Admin on 17/2/16.
//  Copyright © 2017年 Wind. All rights reserved.
//

import UIKit

protocol WGTableHeaderDelegate {
    func didChangesShowInfo(headerView: WGTableHeader, showInfo: Bool)
}

class WGTableHeader: UIView {

    var infoButton: UIButton?
    var historyButton: UIButton?
    var delegate: WGTableHeaderDelegate?
    var show: Bool = true {
        didSet {
            initSubViews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubViews() -> Void {
        if infoButton == nil {
            infoButton = UIButton.init(type: .system)
            infoButton?.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width / 2 - 10, height: self.frame.size.height - 10)
            infoButton?.center = CGPoint.init(x: self.frame.size.width / 4, y: self.frame.size.height / 2)
            infoButton?.setTitle("Infomation", for: .normal)
            infoButton?.addTarget(self, action: #selector(onAction(_ :)), for: .touchUpInside)
            self.addSubview(infoButton!)
        }
        infoButton?.setTitleColor((show ? .blue : .black), for: .normal)
        
        if historyButton == nil {
            historyButton = UIButton.init(type: .system)
            historyButton?.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width / 2 - 10, height: self.frame.size.height - 10)
            historyButton?.center = CGPoint.init(x: self.frame.size.width * 3 / 4, y: self.frame.size.height / 2)
            historyButton?.setTitle("History", for: .normal)
            historyButton?.addTarget(self, action: #selector(onAction(_:)), for: .touchUpInside)
            self.addSubview(historyButton!)
        }
        historyButton?.setTitleColor((show ? .black : .blue), for: .normal)
    }
    
    func onAction(_ button: UIButton) -> Void {
        if button.titleLabel?.text == "Infomation" {
            show = true
        } else if button.titleLabel?.text == "History" {
            show = false
        }
        
        delegate?.didChangesShowInfo(headerView: self, showInfo: show)
    }
    
    
    
    
}
