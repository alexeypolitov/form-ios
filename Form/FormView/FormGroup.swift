//
//  FormGroup.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/17.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import Foundation

open class FormGroup {
    var header: FormHeaderFooter?
    var cells: [FormCell] = []
    var footer: FormHeaderFooter?
    
    init(header: FormHeaderFooter? = nil, _ cells: [FormCell] = [], footer: FormHeaderFooter? = nil) {
        self.header = header
        self.cells = cells
        self.footer = footer
    }
}

// MARK: - Setters

extension FormGroup {
    
    func header(_ container: FormHeaderFooter) -> FormGroup {
        self.header = container
        return self
    }
    
    func footer(_ container: FormHeaderFooter) -> FormGroup {
        self.footer = container
        return self
    }
    
    func add(_ container: FormCell) -> FormGroup {
        cells.append(container)
        return self
    }
    
}

class FormDefaultGroup: FormGroup {
    
}
