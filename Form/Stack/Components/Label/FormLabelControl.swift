//
//  FormLabelControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormLabelControl: FormStackControl, FormLabelStackControlElementDelegate, FormControlSelectable {
    
    lazy var formTextLabel: FormLabelStackControlElement = {
        let label = FormLabelStackControlElement(isMain: true)
        label.labelDelegate = self
        return label
    }()
    
    lazy var formDetailTextLabel: FormLabelStackControlElement = {
        let label = FormLabelStackControlElement(isMain: false)
        label.textAlignment = .right
        label.labelDelegate = self
        return label
    }()
    
    init(name: String = UUID().uuidString, text: String? = nil, detail: String? = nil) {
        super.init(name: name)
        
        formTextLabel.text = text
        formDetailTextLabel.text = detail
    }
    
    // MARK: - FormLabelStackControlElementDelegate
    
    func labelDidChanged(label: FormLabelStackControlElement) {
        layoutElements()
        buildLayout()
    }
    
    open func layoutElements() {
        
        if elements.firstIndex(where: {$0.name == formTextLabel.name}) == nil {
            elements.append(formTextLabel)
        }
        
        if
            (formDetailTextLabel.text == nil || formTextLabel.text?.count == 0) &&
            (formDetailTextLabel.attributedText == nil || formDetailTextLabel.attributedText?.length == 0)
        {
            if let index = elements.firstIndex(where: {$0.name == formDetailTextLabel.name}) {
                elements.remove(at: index)
            }
        } else {
            if elements.firstIndex(where: {$0.name == formDetailTextLabel.name}) == nil {
                elements.append(formDetailTextLabel)
            }
        }
        
    }
    
    // MARK: - FormControlSelectable
    
    private var _selectionStyle: UITableViewCell.SelectionStyle = .default
    var selectionStyle: UITableViewCell.SelectionStyle {
        get {
            if onSelectHandler == nil {
                return .none
            } else {
                return _selectionStyle
            }
        }
        set {
            _selectionStyle = newValue
        }
    }
    private var _accessoryType: UITableViewCell.AccessoryType = .none
    var accessoryType: UITableViewCell.AccessoryType {
        get {
            return _accessoryType
        }
        set {
            _accessoryType = newValue
        }
    }
    var onSelectHandler: ((FormLabelControl) -> Void)?
    
    func formControlOnSelect() {
        onSelectHandler?(self)
    }
}
