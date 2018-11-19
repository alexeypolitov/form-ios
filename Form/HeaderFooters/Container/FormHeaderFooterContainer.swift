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
    var element: FormControllable?
    var insets: UIEdgeInsets = UIEdgeInsets.zero
    
    override init(_ name: String = UUID().uuidString) {
        super.init(name)
        
        self.insets = FormHeaderFooterContainer.appearance.insets
    }
    
    override func onPrepare(_ view: FormHeaderFooterView) {
        guard let `view` = view as? FormHeaderFooterContainerView else { return }
        
        view.dataSource = self
    }
    
    class Appearance {
        var insets: UIEdgeInsets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
    }
    
    static let appearance = Appearance()
    
}

// MARK: - FormHeaderFooterContainerViewDataSource

extension FormHeaderFooterContainer: FormHeaderFooterContainerViewDataSource {
    
    func formHeaderFooterContainerViewElement(_ view: FormHeaderFooterContainerView) -> FormControllable? {
        return element
    }
    
    func formHeaderFooterContainerViewInsets(_ view: FormHeaderFooterContainerView) -> UIEdgeInsets? {
        return insets
    }
    
}

// MARK: - FormLayoutable

extension FormHeaderFooterContainer: FormLayoutable {
    
    func updateControlLayout(element: FormControllable) {
        updateFormView()
    }
    
}

// MARK: - FormSearchable

extension FormHeaderFooterContainer: FormSearchable {
    
    func control(_ name: String) -> FormControllable? {
        if element?.name == name {
            return element
        }
        if let `element` = element as? FormSearchable {
            return element.control(name)
        }        
        return nil
    }
    
}

// MARK: - Setters

extension FormHeaderFooterContainer {
    
    func element(_ element: FormControllable?) -> FormHeaderFooterContainer {
        self.element = element
        self.element?.layoutDelegate = self
        return self
    }
    
    func insets(_ insets: UIEdgeInsets) -> FormHeaderFooterContainer {
        self.insets = insets
        return self
    }
}
