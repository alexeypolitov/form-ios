//
//  FormRegExValidator.swift
//  Form
//
//  Created by Alexey Politov on 2019/03/12.
//  Copyright © 2019 Alexey Politov. All rights reserved.
//

import Foundation

public class FormRegExValidator: FormValidator {
    
    public var pattern: String
    
    public init(pattern: String,_ message: String) {
        self.pattern = pattern
        
        super.init(priority: .high, message: message)
    }
    
    public override func validate(_ field: FormField) -> Bool {
        guard let value = field.value as? String else {
            return true
        }        
        let predicate = NSPredicate(format:"SELF MATCHES %@", pattern)
        return predicate.evaluate(with: value)
    }
    
}
