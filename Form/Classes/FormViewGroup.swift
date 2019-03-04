//
//  FormGroup.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/17.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import Foundation

open class FormViewGroup {
    public let name: String
    open var header: FormViewHeaderFooter?
    open var rows: [FormViewCell] = []
    open var footer: FormViewHeaderFooter?
    public var formView: FormView?
    private var _isHidden: Bool = false
    open var isHidden: Bool {
        get {
            return _isHidden
        }
        set {
            _isHidden = newValue
            formView?.reloadData()
        }
    }
    
    public init(_ name: String = UUID().uuidString, _ initializer: @escaping (FormViewGroup) -> Void) {
        self.name = name
        initializer(self)
    }
    
    public init(name: String = UUID().uuidString, header: FormViewHeaderFooter? = nil, _ rows: [FormViewCell] = [], footer: FormViewHeaderFooter? = nil, _ initializer: @escaping (FormViewGroup) -> Void = { _ in }) {
        self.name = name
        self.header = header
        self.rows = rows
        self.footer = footer
        
        initializer(self)
    }
    
    open func hideInputSource() {
        for row in rows {
            if let `row` = row as? FormViewLayoutable {
                row.hideInputSource()
            }            
        }
    }
}

// MARK: - FormViewSearchable

extension FormViewGroup: FormViewSearchable {
    
    open func control(_ name: String) -> FormViewControllable? {
        
        if let `header` = header as? FormViewSearchable {
            if let control = header.control(name) {
                return control
            }
        }
            
        for row in rows {
            if let `row` = row as? FormViewSearchable {
                if let control = row.control(name) {
                    return control
                }
            }
            
        }
            
        if let `footer` = footer as? FormViewSearchable {
            if let control = footer.control(name) {
                return control
            }
        }
        
        return nil
    }
    
    open func bindableControls(_ bindName: String) -> [FormViewBindable] {
        var list: [FormViewBindable] = []
        
        if let `header` = header as? FormViewSearchable {
            list.append(contentsOf: header.bindableControls(bindName))
        }

        for row in rows {
            if let `row` = row as? FormViewSearchable {
                list.append(contentsOf: row.bindableControls(bindName))
            }
            
        }
        
        if let `footer` = footer as? FormViewSearchable {
            list.append(contentsOf: footer.bindableControls(bindName))
        }
        
        return list
    }
    
}
