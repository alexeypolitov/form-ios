//
//  FormGroup.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/17.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import Foundation

open class FormGroup {
    open var header: FormHeaderFooter?
    open var rows: [FormCell] = []
    open var footer: FormHeaderFooter?
    
    init(header: FormHeaderFooter? = nil, _ rows: [FormCell] = [], footer: FormHeaderFooter? = nil) {
        self.header = header
        self.rows = rows
        self.footer = footer
    }
}

// MARK: - FormSearchable

extension FormGroup: FormSearchable {
    
    open func control(_ name: String) -> FormControllable? {
        
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
    
    open func bindableControls(_ bindName: String) -> [FormBindable] {
        var list: [FormBindable] = []
        
        if let `header` = header as? FormSearchable {
            list.append(contentsOf: header.bindableControls(bindName))
        }

        for row in rows {
            if let `row` = row as? FormSearchable {
                list.append(contentsOf: row.bindableControls(bindName))
            }
            
        }
        
        if let `footer` = footer as? FormSearchable {
            list.append(contentsOf: footer.bindableControls(bindName))
        }
        
        return list
    }
    
}

// MARK: - Setters

extension FormGroup {
    
    open func header(_ container: FormHeaderFooter) -> FormGroup {
        self.header = container
        return self
    }
    
    open func header(_ control: FormControllable) -> FormGroup {
        self.header = FormHeaderFooterContainer().control(control)
        return self
    }
    
    open func footer(_ container: FormHeaderFooter) -> FormGroup {
        self.footer = container
        return self
    }
    
    open func footer(_ control: FormControllable) -> FormGroup {
        self.footer = FormHeaderFooterContainer().control(control)
        return self
    }
    
    open func add(_ container: FormCell) -> FormGroup {
        rows.append(container)
        return self
    }
    
    open func add(_ control: FormControllable) -> FormGroup {
        rows.append(FormCellContainer().control(control))
        return self
    }
    
}

class FormDefaultGroup: FormGroup {
    
}
