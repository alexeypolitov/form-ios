//
//  FormValidator.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import Foundation

open class FormValidator {

    public enum Priority {
        case low
        case medium
        case high
    }
    
    open var priority: Priority
    open var message: String
    
    public init(priority: Priority, message: String) {
        self.priority = priority
        self.message = message
    }
        
    open func validate(_ field: FormField) -> Bool {
        fatalError("Subclasses need to implement the `validate` variable.")
    }
    
}
