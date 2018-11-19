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

// MARK: - FormSearchable

extension FormGroup: FormSearchable {
    
    func control(_ name: String) -> FormControllable? {
        
        if let `header` = header as? FormSearchable {
            if let control = header.control(name) {
                return control
            }
        }
            
        for row in rows {
            if let `row` = row as? FormSearchable {
                if let control = row.control(name) {
                    return control
                }
            }
            
        }
            
        if let `footer` = footer as? FormSearchable {
            if let control = footer.control(name) {
                return control
            }
        }
        
        return nil
    }
    
}

// MARK: - FormValidatable

extension FormGroup: FormValidatable {
    
    func validate() -> (Bool, String?) {
        
//        if let `header` = header as? FormSearchable {
//            if let control = header.control(name) {
//                return control
//            }
//        }
        
        for row in rows {
            if let `row` = row as? FormValidatable {
                let (success, message) = row.validate()
                if !success {
                    return (success, message)
                }
            }
            
        }
        
//        if let `footer` = footer as? FormSearchable {
//            if let control = footer.control(name) {
//                return control
//            }
//        }
        
        return (true, nil)
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
