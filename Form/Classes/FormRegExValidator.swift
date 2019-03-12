//
//  FormRegExValidator.swift
//  Form
//
//  Created by Alexey Politov on 2019/03/12.
//  Copyright © 2019 Alexey Politov. All rights reserved.
//

import Foundation

public class FormRegExValidator: FormValidator {
    
    public init(_ message: String) {
        super.init(priority: .high, message: message)
    }
    
    public override func validate(_ field: FormField) -> Bool {
        guard let value = field.value as? String else {
            return true
        }
        let regExp = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regExp)
        return predicate.evaluate(with: value)
    }
    
}
