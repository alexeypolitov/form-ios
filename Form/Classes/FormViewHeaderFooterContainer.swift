//
//  FormHeaderFooterContainer.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewHeaderFooterContainer: FormViewHeaderFooter {

    open override var viewClass: FormViewHeaderFooterView.Type { return FormViewHeaderFooterContainerView.self }
    open var control: FormControllable?
    open var insets: UIEdgeInsets = UIEdgeInsets.zero
    
    override init(_ name: String = UUID().uuidString, isFooter: Bool = false) {
        super.init(name)

        if isFooter {
            self.insets = FormViewHeaderFooterContainer.appearanceFooter.insets
        } else {
            self.insets = FormViewHeaderFooterContainer.appearanceHeader.insets
        }

    }
    
    open override func onPrepare() {
        if let `bindable` = control as? FormBindable {
            bindable.refreshBindValue()
        }

        if let `onLoad` = control as? FormOnLoad, let control = control {
            onLoad.prepareOnLoad()
            onLoad.onLoad?(control)
        }

        guard let `linkedView` = linkedView as? FormViewHeaderFooterContainerView else { return }
        linkedView.dataSource = self
    }
    
    open class Appearance {
        
        var insets: UIEdgeInsets
        init(_ insets:UIEdgeInsets = UIEdgeInsets.zero) {
            self.insets = insets
        }        
    }
    
    public static let appearanceHeader = Appearance(UIEdgeInsets(top: 20, left: 16, bottom: 8, right: 16))
    public static let appearanceFooter = Appearance(UIEdgeInsets(top: 8, left: 16, bottom: 20, right: 16))
    
}

// MARK: - FormContainerable

extension FormViewHeaderFooterContainer: FormContainerable {
    
    // MARK: - Containerable
    open func controlsNames() -> [String] {
        var list: [String] = []
        if let controlnName = control?.name {
            list.append(controlnName)
        }
        if let `control` = control as? FormContainerable {
            list.append(contentsOf: control.controlsNames())
        }
        return list
        
    }
    
}

// MARK: - FormHeaderFooterContainerViewDataSource

extension FormViewHeaderFooterContainer: FormViewHeaderFooterContainerViewDataSource {
    
    open func formViewHeaderFooterContainerViewControl(_ view: FormViewHeaderFooterContainerView) -> FormControllable? {
        return control
    }
    
    open func formViewHeaderFooterContainerViewInsets(_ view: FormViewHeaderFooterContainerView) -> UIEdgeInsets? {
        return insets
    }
    
}

// MARK: - FormLayoutable

extension FormViewHeaderFooterContainer: FormLayoutable {
    
    open func updateControlLayout(element: FormControllable) {
        updateFormView()
    }
    
}

// MARK: - FormSearchable

extension FormViewHeaderFooterContainer: FormSearchable {
    
    open func control(_ name: String) -> FormControllable? {
        if control?.name == name {
            return control
        }
        if let `control` = control as? FormSearchable {
            return control.control(name)
        }        
        return nil
    }
    
    open func bindableControls(_ bindName: String) -> [FormBindable] {
        var list: [FormBindable] = []
        if let `control` = control as? FormBindable {
            if control.bindName == bindName {
                list.append(control)
            }            
        }
        if let `control` = control as? FormSearchable {
            list.append(contentsOf: control.bindableControls(bindName))
        }
        return list
    }
    
}

// MARK: - FormViewBindDelegate

extension FormViewHeaderFooterContainer: FormViewBindDelegate {
    
    open func bindValueChanged(control: FormControllable, bindName: String, value: Any?) {
        formView?.bindValueChanged(control: control, bindName: bindName, value: value)
    }
    
    open func bindValue(_ bindName: String) -> Any? {
        return formView?.bindValue(bindName)
    }
    
}

// MARK: - Setters

extension FormViewHeaderFooterContainer {
    
    open func control(_ control: FormControllable?) -> FormViewHeaderFooterContainer {
        self.control = control
        self.control?.layoutDelegate = self
        if let bindable = control as? FormBindable {
            bindable.bindDelegate(self)
        }  
        return self
    }
    
    open func insets(_ insets: UIEdgeInsets) -> FormViewHeaderFooterContainer {
        self.insets = insets
        return self
    }
}
