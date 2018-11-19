//
//  Form.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import Foundation

class Form {

    // Control
    
    static func label(_ name: String = UUID().uuidString) -> FormLabelControl {
        return FormLabelControl(name)
    }
    
    static func badge(_ name: String = UUID().uuidString) -> FormBadgeControl {
        return FormBadgeControl(name)
    }
    
    static func textField(_ name: String = UUID().uuidString) -> FormTextFieldControl {
        return FormTextFieldControl(name)
    }
    
    static func textView(_ name: String = UUID().uuidString) -> FormTextViewControl {
        return FormTextViewControl(name)
    }
    
    static func switcher(_ name: String = UUID().uuidString) -> FormSwitcherControl {
        return FormSwitcherControl(name)
    }
    
    static func image(_ name: String = UUID().uuidString) -> FormImageControl {
        return FormImageControl(name)
    }
    
    static func button(_ name: String = UUID().uuidString) -> FormButtonControl {
        return FormButtonControl(name)
    }
    
    static func vertical(_ name: String = UUID().uuidString) -> FormVerticalContainerControl {
        return FormVerticalContainerControl(name)
    }
    
    static func horizontal(_ name: String = UUID().uuidString) -> FormHorizontalContainerControl {
        return FormHorizontalContainerControl(name)
    }
    
    // Group
    
    static func group(_ name: String = UUID().uuidString) -> FormGroup {
        return FormGroup()
    }

    // Container
    
    static func header(_ name: String = UUID().uuidString) -> FormHeaderFooterContainer {
        return FormHeaderFooterContainer(name)
    }
    
    static func footer(_ name: String = UUID().uuidString) -> FormHeaderFooterContainer {
        return FormHeaderFooterContainer(name)
    }
    
    static func row(_ name: String = UUID().uuidString) -> FormCellContainer {
        return FormCellContainer(name)
    }
    
    // Validator
    
    static func required(_ message: String) -> FormRequiredValidator {
        return FormRequiredValidator(message)
    }
    
    static func email(_ message: String) -> FormEmailValidator {
        return FormEmailValidator(message)
    }
    
    static func maxLength(maxLength: Int,_ message: String) -> FormMaxLengthValidator {
        return FormMaxLengthValidator(maxLength: maxLength, message)
    }
    
    static func minLength(minLength: Int,_ message: String) -> FormMinLengthValidator {
        return FormMinLengthValidator(minLength: minLength, message)
    }
    
    static func between(minLength: Int, maxLength: Int,_ message: String) -> FormBetweenLengthValidator {
        return FormBetweenLengthValidator(minLength: minLength, maxLength: maxLength, message)
    }
    
    
    
}
