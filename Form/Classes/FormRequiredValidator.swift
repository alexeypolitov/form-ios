//
//  FormRequiredValidator.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import Foundation

public class FormRequiredValidator: FormValidator {
    
    init(_ message: String) {
        super.init(priority: .high, message: message)
    }
    
    override func validate(_ field: FormField) -> Bool {
        if let value = field.value as? Bool {
            return value
        } else {
            return field.value != nil
        }
    }
    
}
