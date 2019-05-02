//
//  Form.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import Foundation

public class Former {

    // Control
    
    public static func label(_ name: String = UUID().uuidString) -> FormViewLabel {
        return FormViewLabel(name)
    }
    
    public static func badge(_ name: String = UUID().uuidString) -> FormViewBadge {
        return FormViewBadge(name)
    }
    
    public static func textField(_ name: String = UUID().uuidString) -> FormViewTextField {
        return FormViewTextField(name)
    }
    
    public static func textView(_ name: String = UUID().uuidString) -> FormViewTextView {
        return FormViewTextView(name)
    }
    
    public static func switcher(_ name: String = UUID().uuidString) -> FormViewSwitcher {
        return FormViewSwitcher(name)
    }
    
    public static func image(_ name: String = UUID().uuidString) -> FormViewImageView {
        return FormViewImageView(name)
    }
    
    public static func button(_ name: String = UUID().uuidString) -> FormViewButton {
        return FormViewButton(name)
    }
    
    public static func vertical(_ name: String = UUID().uuidString) -> FormViewVerticalContainer {
        return FormViewVerticalContainer(name)
    }
    
    public static func horizontal(_ name: String = UUID().uuidString) -> FormViewHorizontalContainer {
        return FormViewHorizontalContainer(name)
    }
    
    // Group
    
    public static func group(_ name: String = UUID().uuidString) -> FormViewGroup {
        return FormViewGroup()
    }

    // Container
    
    public static func header(_ name: String = UUID().uuidString) -> FormViewHeaderFooterContainer {
        return FormViewHeaderFooterContainer(name)
    }
    
    public static func footer(_ name: String = UUID().uuidString) -> FormViewHeaderFooterContainer {
        return FormViewHeaderFooterContainer(name)
    }
    
    public static func row(_ name: String = UUID().uuidString) -> FormViewCellContainer {
        return FormViewCellContainer(name)
    }
    
    // Validator
    
    public static func required(_ message: String) -> FormRequiredValidator {
        return FormRequiredValidator(message)
    }
    
    public static func email(_ message: String) -> FormEmailValidator {
        return FormEmailValidator(message)
    }
    
    public static func maxLength(maxLength: Int,_ message: String) -> FormMaxLengthValidator {
        return FormMaxLengthValidator(maxLength: maxLength, message)
    }
    
    public static func minLength(minLength: Int,_ message: String) -> FormMinLengthValidator {
        return FormMinLengthValidator(minLength: minLength, message)
    }
    
    public static func between(minLength: Int, maxLength: Int,_ message: String) -> FormBetweenLengthValidator {
        return FormBetweenLengthValidator(minLength: minLength, maxLength: maxLength, message)
    }
    
    public static func custom(handle: @escaping (() -> Bool), _ message: String) -> FormCustomValidator {
        return FormCustomValidator(handle: handle, message)
    }
    
//    // Header Footer
//    public static func emptyHeaderFooter() -> FormViewHeaderFooterEmpty {
//        return FormViewHeaderFooterEmpty()
//    }
        
}
