//
//  FormCell.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

protocol FormCellSelectable {
    var selectionStyle: UITableViewCell.SelectionStyle? { get set }
    var accessoryType: UITableViewCell.AccessoryType? { get set }
    func formCellOnSelect()
}

open class FormCell {
    
    open var viewClass: FormCellView.Type { return FormCellView.self }
    open weak var linkedView: FormCellView?
    weak var linkedFormView: FormView?
    let name: String
    
    init(_ name: String = UUID().uuidString) {
        self.name = name
    }
    
    func prepare(_ view: FormCellView, formView: FormView) {
        linkedView = view
        linkedFormView = formView
        onPrepare()
    }
    
    func onPrepare() {
        // custom code
    }
    
    func processed() {
        onProcessed()
    }
    
    func onProcessed() {
        // custom code
    }
    
    func updateFormView() {
//        guard let formView = linkedView?.superview?.superview as? FormView else { return }
        formView?.updateControls()
    }
    
    var formView: FormView? {
//        guard let formView = linkedView?.superview?.superview as? FormView else { return nil }
        return linkedFormView
    }
}
