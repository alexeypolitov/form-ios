//
//  Form.swift
//  BearClerk
//
//  Created by Alexey Politov on 2018/08/28.
//  Copyright © 2018 Section 9. All rights reserved.
//

import Foundation

class Form {
    
    var fields: [FormField]
    
    init(_ fields: [FormField] = []) {
        self.fields = fields        
    }
    
//    func add(_ field: FormField) {
//        fields.append(field)
//    }
    
    func add(_ field: FormField) -> Form {
        fields.append(field)
        return self
    }
    
    func field(name: String) -> FormField? {
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
    
}
