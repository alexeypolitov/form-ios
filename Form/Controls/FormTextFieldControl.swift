//
//  FormTextField.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

class FormTextFieldControl: FormStackControl {

    lazy var formLabel: FormLabelStackControlElement = {
        let label = FormLabelStackControlElement(isMain: true)
        label.layoutDelegate = self
        return label
    }()
    
    lazy var formTextField: FormTextFieldStackControlElement = {
        let textField = FormTextFieldStackControlElement(isMain: false)
        
        return textField
    }()
    
    var textFieldTextAlignment:NSTextAlignment?
    
    init(name: String = UUID().uuidString, label: String? = nil, text: String? = nil, textPlaceholder: String? = nil) {
        super.init(name: name)
        
        formLabel.text = label
        formTextField.text = text
        formTextField.placeholder = textPlaceholder
        
        prepareElements()
    }
    
//    // MARK: - FormStackControlElementLayoutDelegate
//    
//    func updateControlLayout(element: FormStackControlElement) {
//        prepareElements()
//    }
    
    override func prepareElements() {
        
        if
            (formLabel.text == nil || formLabel.text?.count == 0) &&
            (formLabel.attributedText == nil || formLabel.attributedText?.length == 0)
        {
            if let index = elements.firstIndex(where: {$0.name == formLabel.name}) {
                elements.remove(at: index)
            }
        } else {
            if elements.firstIndex(where: {$0.name == formLabel.name}) == nil {
                elements.insert(formLabel, at: 0)
            }
        }
        
        if elements.firstIndex(where: {$0.name == formTextField.name}) == nil {
            elements.append(formTextField)
        }
        
        // Main
        if let _ = elements.firstIndex(where: {$0.name == formLabel.name}) {
            formLabel.isMain = true
            formTextField.isMain = false
        } else {
            formLabel.isMain = false
            formTextField.isMain = true
        }
        
        // Alignment
        
        if let `textFieldTextAlignment` = textFieldTextAlignment {
            formTextField.textAlignment = textFieldTextAlignment
        } else {
            if let _ = elements.firstIndex(where: {$0.name == formLabel.name}) {
                formTextField.textAlignment = .right
            } else {
                formTextField.textAlignment = .left
            }
        }
        
    }
    
}
