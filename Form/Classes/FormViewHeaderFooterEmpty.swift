//
//  FormViewHeaderFooterEmpty.swift
//  Form
//
//  Created by Alexey Politov on 2019/04/17.
//  Copyright © 2019 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewHeaderFooterEmpty: FormViewHeaderFooter {
    
    open override var viewClass: FormViewHeaderFooterView.Type { return FormViewHeaderFooterEmptyView.self }    
    
    open override func onPrepare() {        
        guard let `linkedView` = linkedView as? FormViewHeaderFooterEmptyView else { return }
        linkedView.updateLayout()
    }
    
}



//// MARK: - FormViewLayoutable
//
//extension FormViewHeaderFooterEmpty: FormViewLayoutable {
//
//    open func updateControlLayout(element: FormViewControllable) {
//        updateFormView()
//    }
//
//    open func inputSourceWillShow(_ notification: Notification) {
//        linkedFormView?.inputSourceWillShow(notification, container: self)
//    }
//
//    open func inputSourceWillHide(_ notification: Notification) {
//        linkedFormView?.inputSourceWillHide(notification)
//    }
//
//    open func hideInputSource() {
//        if let `control` = control as? FormViewLayoutable {
//            control.hideInputSource()
//        }
//        if let `control` = control as? FormViewInputable {
//            control.hideInputSource()
//        }
//    }
//
//}
//

