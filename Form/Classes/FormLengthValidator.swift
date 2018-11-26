//
//  FormLengthValidator.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import Foundation

public class FormMaxLengthValidator: FormValidator {
    
    public var maxLength: Int
    
    public init(maxLength: Int,_ message: String) {
        self.maxLength = maxLength
        
        super.init(priority: .medium, message: message)
    }
    
    public override func validate(_ field: FormField) -> Bool {
        guard let value = field.value as? String else { return true }
        
        return value.count <= maxLength
    }
    
}

public class FormMinLengthValidator: FormValidator {
    
    public var minLength: Int
    
    public init(minLength: Int,_ message: String) {
        self.minLength = minLength
        
        super.init(priority: .medium, message: message)
    }
    
    public override func validate(_ field: FormField) -> Bool {
        guard let value = field.value as? String else { return true }
        return value.count >= minLength
    }
    
}

public class FormBetweenLengthValidator: FormValidator {
    
    public var minLength: Int
    public var maxLength: Int
    
    public init(minLength: Int, maxLength: Int,_ message: String) {
        self.minLength = minLength
        self.maxLength = maxLength
        
        super.init(priority: .medium, message: message)
    }
    
    public override func validate(_ field: FormField) -> Bool {
        guard let value = field.value as? String else { return true }
        return value.count >= minLength && value.count <= maxLength
    }
    
}

