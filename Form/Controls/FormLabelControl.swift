//
//  FormLabelControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormLabelControl: FormStackControl {
    
    lazy var formTextLabel: FormLabelStackControlElement = {
        let label = FormLabelStackControlElement(isMain: true)
        label.layoutDelegate = self
        return label
    }()
    
    init(name: String = UUID().uuidString, text: String? = nil) {
        super.init(name: name)
        
        formTextLabel.text = text
    }

    override func prepareElements() {
        
        if elements.firstIndex(where: {$0.name == formTextLabel.name}) == nil {
            elements.append(formTextLabel)
        }              
        
    }
    
    // MARK: - FormControlSelectable
//    
//    private var _selectionStyle: UITableViewCell.SelectionStyle = .default
//    var selectionStyle: UITableViewCell.SelectionStyle {
//        get {
//            if onSelectHandler == nil {
//                return .none
//            } else {
//                return _selectionStyle
//            }
//        }
//        set {
//            _selectionStyle = newValue
//        }
//    }
//    private var _accessoryType: UITableViewCell.AccessoryType = .none
//    var accessoryType: UITableViewCell.AccessoryType {
//        get {
//            return _accessoryType
//        }
//        set {
//            _accessoryType = newValue
//        }
//    }
//    var onSelectHandler: ((FormLabelControl) -> Void)?
//    
//    func formControlOnSelect() {
//        onSelectHandler?(self)
//    }
}
