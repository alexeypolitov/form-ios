//
//  FormEmailValidator.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import Foundation

class FormEmailValidator: FormValidator {
    
    init(message: String) {
        super.init(priority: .high, message: message)
    }
    
    override func validate(_ valuable: FormValuable) -> Bool {
        guard let value = valuable.value as? String else {
            return true
        }
        let regExp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regExp)
        return predicate.evaluate(with: value)
    }
    
}
