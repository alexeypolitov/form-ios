//
//  FormHeaderFooterContainerView.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

protocol FormHeaderFooterContainerViewDataSource {
    func formHeaderFooterContainerViewElement(_ view: FormHeaderFooterContainerView) -> FormStackControlElement?
    func formHeaderFooterContainerViewInsets(_ view: FormHeaderFooterContainerView) -> UIEdgeInsets?
    //    func minimalInsetBetweenElements() -> CGFloat
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
        guard let element = dataSource.formHeaderFooterContainerViewElement(self) else { return }
        guard let elementView = element as? UIView else { return }
        
        let elementInsets = dataSource.formHeaderFooterContainerViewInsets(self) ?? UIEdgeInsets.zero
        
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


//        if let lastElementView = lastElement as? UIView {
//            storeConstrain(view: elementView, constrain: elementView.leftAnchor.constraint(equalTo: lastElementView.rightAnchor, constant: minimalInset))
//        } else {
            storeConstrain(view: elementView, constrain: elementView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: elementInsets.left))
//        }
//
//        if element.isMain {
//            elementView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
//        } else {
//            elementView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
//        }
//
//        // is last
//        if dataSource.numberOfElements() - 1 == index {
//            if let elementSizing = element as? FormStackControlElementSizing, elementSizing.fixedWidth != nil {
//                // do noting
//            } else {
                storeConstrain(view: elementView, constrain: elementView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: elementInsets.right * -1), priority: .defaultHigh)
//            }
//        }
    }

}
