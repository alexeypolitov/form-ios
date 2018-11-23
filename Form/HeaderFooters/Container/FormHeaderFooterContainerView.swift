//
//  FormHeaderFooterContainerView.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

protocol FormHeaderFooterContainerViewDataSource {
    func formHeaderFooterContainerViewControl(_ view: FormHeaderFooterContainerView) -> FormControllable?
    func formHeaderFooterContainerViewInsets(_ view: FormHeaderFooterContainerView) -> UIEdgeInsets?
}

class FormHeaderFooterContainerView: FormHeaderFooterView {

    var dataSource:FormHeaderFooterContainerViewDataSource? {
        didSet {
            updateLayout()
        }
    }
    
    override func onUpdateLayout() {
        
        removeStoredConstrains()
        
        guard let `dataSource` = dataSource else { return }
        guard let control = dataSource.formHeaderFooterContainerViewControl(self) else { return }
        guard let controlView = control as? UIView else { return }
        
        let controlInsets = dataSource.formHeaderFooterContainerViewInsets(self) ?? UIEdgeInsets.zero
        
        self.contentView.addSubview(controlView)
        
        storeConstrain(view: controlView, constrain: controlView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: controlInsets.top))
        storeConstrain(view: self.contentView, constrain: self.contentView.bottomAnchor.constraint(equalTo: controlView.bottomAnchor, constant: controlInsets.bottom), priority: .defaultHigh)

        if let controlSizing = control as? FormSizeable {
            if let fixedHeigth = controlSizing.fixedHeigth {
                storeConstrain(view: controlView, constrain: controlView.heightAnchor.constraint(equalToConstant: fixedHeigth))
            }
            if let fixedWidth = controlSizing.fixedWidth {
                storeConstrain(view: controlView, constrain: controlView.widthAnchor.constraint(equalToConstant: fixedWidth))
            }
        }

        storeConstrain(view: controlView, constrain: controlView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: controlInsets.left))
        
        if let controlSizeable = control as? FormSizeable, controlSizeable.fixedWidth != nil {
            // do noting
        } else {
            storeConstrain(view: controlView, constrain: controlView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: controlInsets.right * -1))
        }
                
    }

}
