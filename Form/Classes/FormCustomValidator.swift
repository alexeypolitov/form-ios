//
//  FormCustomValidator.swift
//  Form
//
//  Created by Alexey Politov on 2019/04/01.
//  Copyright © 2019 Alexey Politov. All rights reserved.
//

import Foundation

public class FormCustomValidator: FormValidator {
    
    public var handle: (() -> Bool)
    
    public init(handle: @escaping (() -> Bool), _ message: String) {
        self.handle = handle
        
        super.init(priority: .high, message: message)
    }
    
    public override func validate(_ field: FormField) -> Bool {
        return handle()
    }
    
}
