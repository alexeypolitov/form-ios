//
//  Form.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import Foundation

class Form {
    
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
