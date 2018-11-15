//
//  FormRightDetailLabelControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

class FormRightDetailLabelControl: FormLabelControl {

    lazy var formDetailTextLabel: FormLabelStackControlElement = {
        let label = FormLabelStackControlElement(isMain: false)
        label.layoutDelegate = self
        label.textAlignment = .right
        return label
    }()
    
    init(name: String = UUID().uuidString, text: String? = nil, detail: String? = nil) {
        super.init(name: name)
        
        formTextLabel.text = text
        formDetailTextLabel.text = detail
    }
    
    override func prepareElements() {
        
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
}
