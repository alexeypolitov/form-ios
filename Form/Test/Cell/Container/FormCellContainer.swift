//
//  FormCellContainer.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

class FormCellContainer: FormCell {

    override var viewClass: FormCellView.Type { return FormCellContainerView.self }
    var element: FormControllable?
    var insets: UIEdgeInsets = UIEdgeInsets.zero
    
    override func onPrepare(_ view: FormCellView) {
        guard let `view` = view as? FormCellContainerView else { return }
        
        view.dataSource = self
    }
}

extension FormCellContainer: FormCellContainerViewDataSource {
    
    func formCellContainerViewElement(_ view: FormCellContainerView) -> FormControllable? {
        return element
    }
    
    func formCellContainerViewInsets(_ view: FormCellContainerView) -> UIEdgeInsets? {
        return insets
    }
    
}

// MARK: - FormStackControlElementLayoutDelegate

extension FormCellContainer: FormStackControlElementLayoutDelegate {
    
    func updateControlLayout(element: FormControllable) {
        updateFormView()
    }
    
}

// MARK: - Setters

extension FormCellContainer {
    
    func element(_ element: FormControllable?) -> FormCellContainer {
        self.element = element
        self.element?.layoutDelegate = self
        return self
    }
    
    func insets(_ insets: UIEdgeInsets) -> FormCellContainer {
        self.insets = insets
        return self
    }
}
