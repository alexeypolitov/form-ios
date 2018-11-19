//
//  Form.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import Foundation

class Form {
    
    static func label(_ name: String = UUID().uuidString) -> FormLabelStackControlElement {
        return FormLabelStackControlElement(name)
    }
    
    static func badge(_ name: String = UUID().uuidString) -> FormBadgeStackControlElement {
        return FormBadgeStackControlElement(name)
    }
    
    static func textField(_ name: String = UUID().uuidString) -> FormTextFieldStackControlElement {
        return FormTextFieldStackControlElement(name)
    }
    
    static func textView(_ name: String = UUID().uuidString) -> FormTextViewStackControlElement {
        return FormTextViewStackControlElement(name)
    }
    
    static func switcher(_ name: String = UUID().uuidString) -> FormSwitchStackControlElement {
        return FormSwitchStackControlElement(name)
    }
    
    static func image(_ name: String = UUID().uuidString) -> FormImageStackControlElement {
        return FormImageStackControlElement(name)
    }
    
    static func group(_ name: String = UUID().uuidString) -> FormGroup {
        return FormGroup()
    }

    static func header(_ name: String = UUID().uuidString) -> FormHeaderFooterContainer {
        return FormHeaderFooterContainer(name)
    }
    
    static func footer(_ name: String = UUID().uuidString) -> FormHeaderFooterContainer {
        return FormHeaderFooterContainer(name)
    }
    
    static func row(_ name: String = UUID().uuidString) -> FormCellContainer {
        return FormCellContainer(name)
    }
    
    
    
}
