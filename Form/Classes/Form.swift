//
//  Form.swift
//  BearClerk
//
//  Created by Alexey Politov on 2018/08/28.
//  Copyright © 2018 Section 9. All rights reserved.
//

import Foundation

public protocol FormBindDelegate {
    func formBindValueChanged(bindName: String, value: Any?, exclude: [String])
}

open class Form {
    
    open var fields: [FormField] = []
    open var bindDelegate: FormBindDelegate?
    
    public init() { }
    
    open func add(_ field: FormField) -> Form {
        field.delegate = self
        fields.append(field)
        return self
    }
    
    open func field(_ name: String) -> FormField? {
        return fields.first(where: {$0.name == name})
    }
    
    open func validate() -> (Bool, String?) {
        for field in fields {
            let (_, error) = field.validate()
            if let error = error {
                return (false, error)
            }
        }
        return (true, nil)
    }
    
}

// MARK: - FormFieldDelegate

extension Form : FormFieldDelegate {
    
    open func valueChanged(field: FormField, value: Any?, exclude: [String]) {
        bindDelegate?.formBindValueChanged(bindName: field.name, value: value, exclude: exclude)
    }
    
}
