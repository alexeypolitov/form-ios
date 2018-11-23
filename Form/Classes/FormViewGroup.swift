//
//  FormGroup.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/17.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import Foundation

open class FormViewGroup {
    open var header: FormViewHeaderFooter?
    open var rows: [FormViewCell] = []
    open var footer: FormViewHeaderFooter?
    
    public init(header: FormViewHeaderFooter? = nil, _ rows: [FormViewCell] = [], footer: FormViewHeaderFooter? = nil) {
        self.header = header
        self.rows = rows
        self.footer = footer
    }
}

// MARK: - FormSearchable

extension FormViewGroup: FormSearchable {
    
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

extension FormViewGroup {
    
    open func header(_ container: FormViewHeaderFooter) -> FormViewGroup {
        self.header = container
        return self
    }
    
    open func header(_ control: FormControllable) -> FormViewGroup {
        self.header = FormViewHeaderFooterContainer().control(control)
        return self
    }
    
    open func footer(_ container: FormViewHeaderFooter) -> FormViewGroup {
        self.footer = container
        return self
    }
    
    open func footer(_ control: FormControllable) -> FormViewGroup {
        self.footer = FormViewHeaderFooterContainer().control(control)
        return self
    }
    
    open func add(_ container: FormViewCell) -> FormViewGroup {
        rows.append(container)
        return self
    }
    
    open func add(_ control: FormControllable) -> FormViewGroup {
        rows.append(FormViewCellContainer().control(control))
        return self
    }
    
}
