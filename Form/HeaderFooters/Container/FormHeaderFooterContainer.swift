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
    var control: FormControllable?
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
    
    func formHeaderFooterContainerViewControl(_ view: FormHeaderFooterContainerView) -> FormControllable? {
        return control
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
        if control?.name == name {
            return control
        }
        if let `control` = control as? FormSearchable {
            return control.control(name)
        }        
        return nil
    }
    
}

// MARK: - Setters

extension FormHeaderFooterContainer {
    
    func control(_ control: FormControllable?) -> FormHeaderFooterContainer {
        self.control = control
        self.control?.layoutDelegate = self
        return self
    }
    
    func insets(_ insets: UIEdgeInsets) -> FormHeaderFooterContainer {
        self.insets = insets
        return self
    }
}
