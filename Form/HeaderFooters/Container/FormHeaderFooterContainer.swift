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
    
    override init(_ name: String = UUID().uuidString, isFooter: Bool = false) {
        super.init(name)

        if isFooter {
            self.insets = FormHeaderFooterContainer.appearanceFooter.insets
        } else {
            self.insets = FormHeaderFooterContainer.appearanceHeader.insets
        }

    }
    
    override func onPrepare(_ view: FormHeaderFooterView) {
        guard let `view` = view as? FormHeaderFooterContainerView else { return }
        
        view.dataSource = self
    }
    
    class Appearance {
        
        var insets: UIEdgeInsets
        init(_ insets:UIEdgeInsets = UIEdgeInsets.zero) {
            self.insets = insets
        }        
    }
    
    static let appearanceHeader = Appearance(UIEdgeInsets(top: 20, left: 16, bottom: 8, right: 16))
    static let appearanceFooter = Appearance(UIEdgeInsets(top: 8, left: 16, bottom: 20, right: 16))
    
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

// MARK: - FormBindDelegate

extension FormHeaderFooterContainer: FormBindDelegate {
    
    func bindValueChanged(bindName: String, value: Any?) {
        formView?.bindValueChanged(bindName: bindName, value: value)
    }
    
}

// MARK: - Setters

extension FormHeaderFooterContainer {
    
    func control(_ control: FormControllable?) -> FormHeaderFooterContainer {
        self.control = control
        self.control?.layoutDelegate = self
        if let bindable = control as? FormBindable {
            bindable.bindDelegate(self)
        }  
        return self
    }
    
    func insets(_ insets: UIEdgeInsets) -> FormHeaderFooterContainer {
        self.insets = insets
        return self
    }
}
