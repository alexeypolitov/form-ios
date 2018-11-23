//
//  FormHeaderFooterContainerView.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

public protocol FormViewHeaderFooterContainerViewDataSource {
    func formViewHeaderFooterContainerViewControl(_ view: FormViewHeaderFooterContainerView) -> FormControllable?
    func formViewHeaderFooterContainerViewInsets(_ view: FormViewHeaderFooterContainerView) -> UIEdgeInsets?
}

open class FormViewHeaderFooterContainerView: FormViewHeaderFooterView {

    open var dataSource:FormViewHeaderFooterContainerViewDataSource? {
        didSet {
            updateLayout()
        }
    }
    
    open override func onUpdateLayout() {
        
        removeFormConstrains()
        
        guard let `dataSource` = dataSource else { return }
        guard let control = dataSource.formViewHeaderFooterContainerViewControl(self) else { return }
        guard let controlView = control as? UIView else { return }
        
        let controlInsets = dataSource.formViewHeaderFooterContainerViewInsets(self) ?? UIEdgeInsets.zero
        
        self.contentView.addSubview(controlView)
        
        addFormConstrain(view: controlView, constrain: controlView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: controlInsets.top))
        addFormConstrain(view: self.contentView, constrain: self.contentView.bottomAnchor.constraint(equalTo: controlView.bottomAnchor, constant: controlInsets.bottom), priority: .defaultHigh)

        if let controlSizing = control as? FormSizeable {
            if let fixedHeigth = controlSizing.fixedHeigth {
                addFormConstrain(view: controlView, constrain: controlView.heightAnchor.constraint(equalToConstant: fixedHeigth))
            }
            if let fixedWidth = controlSizing.fixedWidth {
                addFormConstrain(view: controlView, constrain: controlView.widthAnchor.constraint(equalToConstant: fixedWidth))
            }
        }

        addFormConstrain(view: controlView, constrain: controlView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: controlInsets.left))
        
        if let controlSizeable = control as? FormSizeable, controlSizeable.fixedWidth != nil {
            // do noting
        } else {
            addFormConstrain(view: controlView, constrain: controlView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: controlInsets.right * -1))
        }
                
    }

}
