//
//  FormHeaderFooter.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewHeaderFooter {
    
    public var viewClass: FormViewHeaderFooterView.Type { return FormViewHeaderFooterView.self }
    public weak var linkedView: FormViewHeaderFooterView?
    public weak var linkedFormView: FormView?
    public let name: String
    private var _prepareInProgress: Bool = false
    public var prepareInProgress: Bool {
        return _prepareInProgress
    }
    
    init(_ name: String = UUID().uuidString, isFooter: Bool = false) {
        self.name = name
    }
    
    public func prepare(_ view: FormViewHeaderFooterView, formView: FormView) {
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
