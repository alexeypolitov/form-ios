//
//  FormRequiredValidator.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import Foundation

class FormRequiredValidator: FormValidator {
    
    init(_ message: String) {
        super.init(priority: .high, message: message)
    }
    
    override func validate(_ valuable: FormValuable) -> Bool {
        if let value = valuable.value as? Bool {
            return value
        } else {
            return valuable.value != nil
        }
    }
    
}
