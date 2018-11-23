//
//  FormCellContainerView.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

public protocol FormViewCellContainerViewDataSource {
    func formViewCellContainerViewControl(_ view: FormViewCellContainerView) -> FormViewControllable?
    func formViewCellContainerViewInsets(_ view: FormViewCellContainerView) -> UIEdgeInsets?
}

open class FormViewCellContainerView: FormViewCellView {

    var dataSource:FormViewCellContainerViewDataSource? {
        didSet {
            updateLayout()
        }
    }

    open override func onUpdateLayout() {
        
        removeFormConstrains()
        
        guard let `dataSource` = dataSource else { return }
        guard let control = dataSource.formViewCellContainerViewControl(self) else { return }
        guard let controlView = control as? UIView else { return }
        
        let controlInsets = dataSource.formViewCellContainerViewInsets(self) ?? UIEdgeInsets.zero
        
        self.contentView.addSubview(controlView)
        
        addFormConstrain(view: controlView, constrain: controlView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: controlInsets.top))
        addFormConstrain(view: self.contentView, constrain: self.contentView.bottomAnchor.constraint(equalTo: controlView.bottomAnchor, constant: controlInsets.bottom), priority: .defaultHigh)
        
        if let controlSizing = control as? FormViewSizeable {
            if let fixedHeigth = controlSizing.fixedHeigth {
                addFormConstrain(view: controlView, constrain: controlView.heightAnchor.constraint(equalToConstant: fixedHeigth))
            }
            if let fixedWidth = controlSizing.fixedWidth {
                addFormConstrain(view: controlView, constrain: controlView.widthAnchor.constraint(equalToConstant: fixedWidth))
            }
        }
        
        addFormConstrain(view: controlView, constrain: controlView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: controlInsets.left))
        
        if let controlSizeable = control as? FormViewSizeable, controlSizeable.fixedWidth != nil {
            // do noting
        } else {
            addFormConstrain(view: controlView, constrain: controlView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: controlInsets.right * -1))
        }
        
    }

}
