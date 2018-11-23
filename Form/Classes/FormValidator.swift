//
//  FormValidator.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import Foundation

open class FormValidator {

    enum Priority {
        case low
        case medium
        case high
    }
    
    var priority: Priority
    var message: String
    
    init(priority: Priority, message: String) {
        self.priority = priority
        self.message = message
    }
        
    func validate(_ field: FormField) -> Bool {
        fatalError("Subclasses need to implement the `validate` variable.")
    }
    
}
