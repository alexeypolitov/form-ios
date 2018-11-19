//
//  FormHeaderFooterContainer.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

class FormHeaderFooterContainer: FormHeaderFooter {

    override var viewClass: FormHeaderFooterView.Type { return FormHeaderFooterContainerView.self }
    var element: FormStackControlElement?
    var insets: UIEdgeInsets = UIEdgeInsets.zero
    
    override func onPrepare(_ view: FormHeaderFooterView) {
        guard let `view` = view as? FormHeaderFooterContainerView else { return }
        
        view.dataSource = self
    }
    
}

extension FormHeaderFooterContainer: FormHeaderFooterContainerViewDataSource {
    
    func formHeaderFooterContainerViewElement(_ view: FormHeaderFooterContainerView) -> FormStackControlElement? {
        return element
    }
    
    func formHeaderFooterContainerViewInsets(_ view: FormHeaderFooterContainerView) -> UIEdgeInsets? {
        return insets
    }
    
}

// MARK: - FormStackControlElementLayoutDelegate

extension FormHeaderFooterContainer: FormStackControlElementLayoutDelegate {
    
    func updateControlLayout(element: FormStackControlElement) {
        updateFormView()
    }
    
}

// MARK: - Setters

extension FormHeaderFooterContainer {
    
    func element(_ element: FormStackControlElement?) -> FormHeaderFooterContainer {
        self.element = element
        self.element?.layoutDelegate = self
        return self
    }
    
    func insets(_ insets: UIEdgeInsets) -> FormHeaderFooterContainer {
        self.insets = insets
        return self
    }
}
