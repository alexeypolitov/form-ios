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
    var rows: [FormCell] = []
    var footer: FormHeaderFooter?
    
    init(header: FormHeaderFooter? = nil, _ rows: [FormCell] = [], footer: FormHeaderFooter? = nil) {
        self.header = header
        self.rows = rows
        self.footer = footer
    }
}

// MARK: - Setters

extension FormGroup {
    
    func header(_ container: FormHeaderFooter) -> FormGroup {
        self.header = container
        return self
    }
    
    func header(_ control: FormControllable) -> FormGroup {
        self.header = FormHeaderFooterContainer().element(control)
        return self
    }
    
    func footer(_ container: FormHeaderFooter) -> FormGroup {
        self.footer = container
        return self
    }
    
    func footer(_ control: FormControllable) -> FormGroup {
        self.footer = FormHeaderFooterContainer().element(control)
        return self
    }
    
    func add(_ container: FormCell) -> FormGroup {
        rows.append(container)
        return self
    }
    
    func add(_ control: FormControllable) -> FormGroup {
        rows.append(FormCellContainer().element(control))
        return self
    }
    
}

class FormDefaultGroup: FormGroup {
    
}
