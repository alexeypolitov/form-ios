//
//  FormCell.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

public protocol FormCellSelectable {
    var selectionStyle: UITableViewCell.SelectionStyle? { get set }
    var accessoryType: UITableViewCell.AccessoryType? { get set }
    func formCellOnSelect()
}

open class FormCell {
    
    public var viewClass: FormCellView.Type { return FormCellView.self }
    public weak var linkedView: FormCellView?
    public weak var linkedFormView: FormView?
    public let name: String
    private var _prepareInProgress: Bool = false
    public var prepareInProgress: Bool {
        return _prepareInProgress
    }
    
    init(_ name: String = UUID().uuidString) {
        self.name = name
    }
    
    public func prepare(_ view: FormCellView, formView: FormView) {
        _prepareInProgress = true
        linkedView = view
        linkedFormView = formView
        onPrepare()
        _prepareInProgress = false
    }
    
    open func onPrepare() {
        // custom code
    }
    
    public func updateFormView() {
        guard !_prepareInProgress else { return }
        formView?.updateControls()
    }
    
    public var formView: FormView? {
        return linkedFormView
    }
}
