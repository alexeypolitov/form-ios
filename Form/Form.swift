//
//  Form.swift
//  BearClerk
//
//  Created by Alexey Politov on 2018/08/28.
//  Copyright © 2018 Section 9. All rights reserved.
//

import Foundation

protocol FormBindDelegate {
    func formBindValueChanged(bindName: String, value: Any?)
}

class Form {
    
    var fields: [FormField] = []
    var bindDelegate: FormBindDelegate?
    
    func add(_ field: FormField) -> Form {
        field.delegate = self
        fields.append(field)
        return self
    }
    
    func field(_ name: String) -> FormField? {
        return fields.first(where: {$0.name == name})
    }
    
    func validate() -> (Bool, String?) {
        for field in fields {
            let (_, error) = field.validate()
            if let error = error {
                return (false, error)
            }
        }
        return (true, nil)
    }
    
    var initialOnChangeControls: [String] {
        var list: [String] = []
        for field in fields {
            for control in field.initialOnChangeControls {
                if list.first(where: {$0 == control}) == nil {
                    list.append(control)
                }
            }
        }
        return list
    }
    
    func processInitialControl(name: String) {
        for field in fields {
            field.processInitialControl(name: name)
        }
    }
    
}

// MARK: - FormFieldDelegate

extension Form : FormFieldDelegate {
    
    func valueChanged(field: FormField, value: Any?) {
        bindDelegate?.formBindValueChanged(bindName: field.name, value: value)
    }
    
}
