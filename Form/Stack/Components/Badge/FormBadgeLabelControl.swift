//
//  FormBadgeLabelControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

class FormBadgeLabelControl: FormLabelControl {

    lazy var formBadgeLabel: FormBadgeStackControlElement = {
        let badge = FormBadgeStackControlElement(isMain: false)
        badge.labelDelegate = self
        return badge
    }()
 
    init(name: String = UUID().uuidString, badge: String? = nil, text: String? = nil, detail: String? = nil) {
        super.init(name: name)
        
        formBadgeLabel.text = badge
        formTextLabel.text = text
        formDetailTextLabel.text = detail
    }
    
    // MARK: - Layout
    
    override func layoutElements() {
        
        if
            (formBadgeLabel.text == nil || formBadgeLabel.text?.count == 0) &&
            (formBadgeLabel.attributedText == nil || formBadgeLabel.attributedText?.length == 0)
        {
            if let index = elements.firstIndex(where: {$0.name == formBadgeLabel.name}) {
                elements.remove(at: index)
            }
        } else {
            if elements.firstIndex(where: {$0.name == formBadgeLabel.name}) == nil {
                elements.insert(formBadgeLabel, at: 0)                
            }
        }
        
        super.layoutElements()
        
    }
}
