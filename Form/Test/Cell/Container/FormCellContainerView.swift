//
//  FormCellContainerView.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

protocol FormCellContainerViewDataSource {
    func formCellContainerViewElement(_ view: FormCellContainerView) -> FormStackControlElement?
    func formCellContainerViewInsets(_ view: FormCellContainerView) -> UIEdgeInsets?
}

class FormCellContainerView: FormCellView {

    var dataSource:FormCellContainerViewDataSource? {
        didSet {
            updateLayout()
        }
    }

    override func onUpdateLayout() {
        
        removeStoredConstrains()
        
        guard let `dataSource` = dataSource else { return }
        guard let element = dataSource.formCellContainerViewElement(self) else { return }
        guard let elementView = element as? UIView else { return }
        
        let elementInsets = dataSource.formCellContainerViewInsets(self) ?? UIEdgeInsets.zero
        
        contentView.addSubview(elementView)
        
        storeConstrain(view: elementView, constrain: elementView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: elementInsets.top))
        storeConstrain(view: contentView, constrain: contentView.bottomAnchor.constraint(equalTo: elementView.bottomAnchor, constant: elementInsets.bottom), priority: .defaultHigh)
        
        if let elementSizing = element as? FormStackControlElementSizing {
            if let fixedHeigth = elementSizing.fixedHeigth {
                storeConstrain(view: elementView, constrain: elementView.heightAnchor.constraint(equalToConstant: fixedHeigth))
            }
            if let fixedWidth = elementSizing.fixedWidth {
                storeConstrain(view: elementView, constrain: elementView.widthAnchor.constraint(equalToConstant: fixedWidth))
            }
        }
        
        storeConstrain(view: elementView, constrain: elementView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: elementInsets.left))
        storeConstrain(view: elementView, constrain: elementView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: elementInsets.right * -1), priority: .defaultHigh)
    }

}
