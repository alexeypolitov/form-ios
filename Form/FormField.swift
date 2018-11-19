//
//  FormField.swift
//  BearClerk
//
//  Created by Alexey Politov on 2018/08/28.
//  Copyright © 2018 Section 9. All rights reserved.
//

import Foundation

open class FormField: NSObject {
    var name: String
    private var _value: Any? {
        didSet {
            if Thread.isMainThread {
                onChange?(_value)
            } else {
                DispatchQueue.main.async {
                    self.onChange?(self._value)
                }
            }
        }
    }
    var value: Any? {
        get {
            return _value
        }
        set {
            _value = newValue            
        }
    }
    var validators: [FormValidator] = []
    var inlineValidators: [FormValidator] = []
    var onChange: ((Any?) -> Void)?
    
    init(_ name: String) {
        self.name = name
    }
    
    func setValueFromFormView(_ value: Any?) {
        self._value = value
    }
    
    func validate() -> (Bool, String?) {
        
        if let message = prepareValidateByPriority(priority: .high) {
            return (false, message)
        }
        
        if let message = prepareValidateByPriority(priority: .medium) {
            return (false, message)
        }
        
        if let message = prepareValidateByPriority(priority: .low) {
            return (false, message)
        }
        
        return (true, nil)
    }
    
    func validate(priority: FormValidator.Priority) -> (Bool, String?) {
        
        if let message = prepareValidateByPriority(priority: priority) {
            return (false, message)
        }
        
        return (true, nil)
    }
    
    private func prepareValidateByPriority(priority: FormValidator.Priority) -> String? {
//        let localValidators = validators.filter { (validator) -> Bool in
//            return validator.priority == priority
//        }
//
//        for validator in localValidators {
//            if !validator.validate(self) {
//                return validator.message
//            }
//        }
        
        return nil
    }
}

// MARK: - Setters

extension FormField {
    
    func value(_ value: Any?) -> FormField {
        self.value = value
        return self
    }
    
    func validators(_ validators: [FormValidator]) -> FormField {
        self.validators = validators
        return self
    }
    
    func validator(_ validator: FormValidator) -> FormField {
        self.validators = [validator]
        return self
    }
    
    func inlineValidators(_ inlineValidators: [FormValidator]) -> FormField {
        self.inlineValidators = inlineValidators
        return self
    }
    
    func inlineValidator(_ inlineValidator: FormValidator) -> FormField {
        self.inlineValidators = [inlineValidator]
        return self
    }
    
    func onChange(_ onChange: ((Any?) -> Void)?) -> FormField {
        self.onChange = onChange
        return self
    }
    
}

extension Form {
    
    static func field(_ name: String) -> FormField {
        return FormField(name)
    }
}
