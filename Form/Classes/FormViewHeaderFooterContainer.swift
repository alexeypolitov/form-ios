//
//  FormHeaderFooterContainer.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewHeaderFooterContainer: FormViewHeaderFooter, FormViewOnLoad {

    open override var viewClass: FormViewHeaderFooterView.Type { return FormViewHeaderFooterContainerView.self }
    open var control: FormViewControllable? {
        didSet {
            self.control?.layoutDelegate = self
            if let bindable = control as? FormViewBindable {
                bindable.bindDelegate(self)
            }
        }
    }
    open var insets: UIEdgeInsets = UIEdgeInsets.zero
    
    public override init(_ name: String = UUID().uuidString, _ initializer: @escaping (FormViewHeaderFooterContainer) -> Void = { _ in }) {
        super.init(name)
        initializer(self)
    }
    
    open override func onPrepare() {
        // Container
        self.onLoad?(self)
        
        // Control
        if let `bindable` = control as? FormViewBindable {
            bindable.refreshBindValue()
        }

        if let `onLoad` = control as? FormViewOnLoad, let control = control {
            onLoad.prepareOnLoad()
            onLoad.onLoad?(control)
        }

        guard let `linkedView` = linkedView as? FormViewHeaderFooterContainerView else { return }
        linkedView.dataSource = self
    }
    
    open class Appearance {
        
        var insets: UIEdgeInsets
        public init(_ insets:UIEdgeInsets = UIEdgeInsets.zero) {
            self.insets = insets
        }        
    }
    
    public static let appearanceHeader = Appearance(UIEdgeInsets(top: 20, left: 16, bottom: 8, right: 16))
    public static let appearanceFooter = Appearance(UIEdgeInsets(top: 8, left: 16, bottom: 20, right: 16))
 
    // MARK: - FormViewOnLoad
    open var onLoad: ((Any) -> Void)?
}

// MARK: - FormViewContainerable

extension FormViewHeaderFooterContainer: FormViewContainerable {
    
    // MARK: - Containerable
    open func controlsNames() -> [String] {
        var list: [String] = []
        if let controlnName = control?.name {
            list.append(controlnName)
        }
        if let `control` = control as? FormViewContainerable {
            list.append(contentsOf: control.controlsNames())
        }
        return list
        
    }
    
}

// MARK: - FormHeaderFooterContainerViewDataSource

extension FormViewHeaderFooterContainer: FormViewHeaderFooterContainerViewDataSource {
    
    open func formViewHeaderFooterContainerViewControl(_ view: FormViewHeaderFooterContainerView) -> FormViewControllable? {
        return control
    }
    
    open func formViewHeaderFooterContainerViewInsets(_ view: FormViewHeaderFooterContainerView) -> UIEdgeInsets? {
        return insets
    }
    
}

// MARK: - FormViewLayoutable

extension FormViewHeaderFooterContainer: FormViewLayoutable {
    
    open func updateControlLayout(element: FormViewControllable) {
        updateFormView()
    }
    
}

// MARK: - FormViewSearchable

extension FormViewHeaderFooterContainer: FormViewSearchable {
    
    open func control(_ name: String) -> FormViewControllable? {
        if control?.name == name {
            return control
        }
        if let `control` = control as? FormViewSearchable {
            return control.control(name)
        }        
        return nil
    }
    
    open func bindableControls(_ bindName: String) -> [FormViewBindable] {
        var list: [FormViewBindable] = []
        if let `control` = control as? FormViewBindable {
            if control.bindName == bindName {
                list.append(control)
            }            
        }
        if let `control` = control as? FormViewSearchable {
            list.append(contentsOf: control.bindableControls(bindName))
        }
        return list
    }
    
}

// MARK: - FormViewBindDelegate

extension FormViewHeaderFooterContainer: FormViewBindDelegate {
    
    open func bindValueChanged(control: FormViewControllable, bindName: String, value: Any?) {
        formView?.bindValueChanged(control: control, bindName: bindName, value: value)
    }
    
    open func bindValue(_ bindName: String) -> Any? {
        return formView?.bindValue(bindName)
    }
    
}
