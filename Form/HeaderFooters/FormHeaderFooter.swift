//
//  FormHeaderFooter.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormHeaderFooter {
    
    open var viewClass: FormHeaderFooterView.Type { return FormHeaderFooterView.self }
    open weak var linkedView: FormHeaderFooterView?
    weak var linkedFormView: FormView?
    let name: String
    
    init(_ name: String = UUID().uuidString, isFooter: Bool = false) {
        self.name = name
    }
    
    func prepare(_ view: FormHeaderFooterView, formView: FormView) {
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