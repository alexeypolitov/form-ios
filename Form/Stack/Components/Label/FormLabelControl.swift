//
//  FormLabelControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

class FormLabelControl: FormStackControl, FormLabelStackControlElementDelegate {

//    enum Style {
//        case single
//        case detail
//    }
    
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
    
    private var observations: [NSKeyValueObservation] = []
    
    init(name: String = UUID().uuidString, text: String? = nil, detail: String? = nil) {
        super.init(name: name)
        
//        elements = [formTextLabel]
        
        formTextLabel.text = text
        formDetailTextLabel.text = detail
        
    }
    
    func labelDidChanged(label: FormLabelStackControlElement) {
//        if label == formTextLabel {
//            print("ddd 1")
//        } else if label == formDetailTextLabel {
//            print("ddd 2")
//        }
        layoutElements()
    }
    
    func layoutElements() {
        
        var changed: Bool = false
        
        if elements.firstIndex(where: {$0.name == formTextLabel.name}) == nil {
            elements.append(formTextLabel)
            changed = true
        }
        
        if
            (formDetailTextLabel.text == nil || formTextLabel.text?.count == 0) &&
            (formDetailTextLabel.attributedText == nil || formDetailTextLabel.attributedText?.length == 0)
        {
            if let index = elements.firstIndex(where: {$0.name == formDetailTextLabel.name}) {
                elements.remove(at: index)
                changed = true
            }
        } else {
            if elements.firstIndex(where: {$0.name == formDetailTextLabel.name}) == nil {
                elements.append(formDetailTextLabel)
                changed = true
            }
        }
        
        if changed {
            buildLayout()
        }
        
    }
    
}
