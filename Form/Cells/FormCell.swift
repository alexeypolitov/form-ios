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
    open weak var linkedview: FormCellView?
    let name: String
    
    init(_ name: String = UUID().uuidString) {
        self.name = name
    }
    
    func prepare(_ view: FormCellView) {
        linkedview = view
        onPrepare(view)
    }
    
    open func onPrepare(_ view: FormCellView) {
        // custom code
    }
    
    func updateFormView() {
        guard let formView = linkedview?.superview?.superview as? FormView else { return }
        formView.updateControls()
    }
}
