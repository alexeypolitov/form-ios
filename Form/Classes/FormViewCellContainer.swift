//
//  FormCellContainer.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewCellContainer: FormViewCell, FormViewCellSelectable {

    open override var viewClass: FormViewCellView.Type { return FormViewCellContainerView.self }
    open var control: FormControllable?
    open var insets: UIEdgeInsets = UIEdgeInsets.zero
    open var minimalInset: CGFloat = 8
    
    override init(_ name: String = UUID().uuidString) {
        super.init(name)
        
        self.insets = FormViewCellContainer.appearance.insets
    }
    
    open override func onPrepare() {
        if let `bindable` = control as? FormBindable {
            bindable.refreshBindValue()
        }
        
        if let `onLoad` = control as? FormOnLoad, let control = control {
            onLoad.prepareOnLoad()
            onLoad.onLoad?(control)
        }
        
        guard let `linkedView` = linkedView as? FormViewCellContainerView else { return }
        linkedView.dataSource = self
    }
    
    open class Appearance {
        var insets: UIEdgeInsets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
    }
    
    public static let appearance = Appearance()
    
    // MARK: - FormCellSelectable
    
    private var _onSelect: ((FormViewCellContainer) -> Void)?
    open var onSelect: ((FormViewCellContainer) -> Void)? {
        get {
            if let `_onSelect` = _onSelect {
                return _onSelect
            } else if let `control` = control as? FormSelectable, let `onSelect` = control.onSelect {
                return onSelect
            }
            return nil
        }
        set {
            _onSelect = newValue
        }
    }    
    private var _selectionStyle: UITableViewCell.SelectionStyle?
    open var selectionStyle: UITableViewCell.SelectionStyle? {
        get {
            if let `_selectionStyle` = _selectionStyle {
                return _selectionStyle
            } else if let `control` = control as? FormSelectable, let `selectionStyle` = control.selectionStyle {
                return selectionStyle
            } else if let _ = onSelect {
                return .default
            } else if let `control` = control as? FormSelectable, let _ = control.onSelect {
                return .default
            }
            return nil
        }
        set {
            _selectionStyle = newValue
        }
    }
    private var _accessoryType: UITableViewCell.AccessoryType?
    open var accessoryType: UITableViewCell.AccessoryType? {
        get {
            if let `_accessoryType` = _accessoryType {
                return _accessoryType
            } else if let `control` = control as? FormSelectable, let `accessoryType` = control.accessoryType {
                return accessoryType
            }
            return nil
        }
        set {
            _accessoryType = newValue
        }
    }
    
    open func formCellOnSelect() {
        onSelect?(self)
    }
    
}

// MARK: - FormContainerable

extension FormViewCellContainer: FormContainerable {
    
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

// MARK: - FormCellContainerViewDataSource

extension FormViewCellContainer: FormViewCellContainerViewDataSource {
    
    open func formViewCellContainerViewControl(_ view: FormViewCellContainerView) -> FormControllable? {
        return control
    }
    
    open func formViewCellContainerViewInsets(_ view: FormViewCellContainerView) -> UIEdgeInsets? {
        return insets
    }
    
}

// MARK: - FormLayoutable

extension FormViewCellContainer: FormLayoutable {
    
    open func updateControlLayout(element: FormControllable) {
        updateFormView()
    }
    
}

// MARK: - FormSearchable

extension FormViewCellContainer: FormSearchable {
    
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

extension FormViewCellContainer: FormViewBindDelegate {
    
    open func bindValueChanged(control: FormControllable, bindName: String, value: Any?) {
        formView?.bindValueChanged(control: control, bindName: bindName, value: value)
    }    
    
    open func bindValue(_ bindName: String) -> Any? {
        return formView?.bindValue(bindName)
    }
    
}

// MARK: - Setters

extension FormViewCellContainer {
    
    open func control(_ control: FormControllable?) -> FormViewCellContainer {
        self.control = control
        self.control?.layoutDelegate = self
        if let bindable = control as? FormBindable {
            bindable.bindDelegate(self)
        }        
        return self
    }
    
    open func insets(_ insets: UIEdgeInsets) -> FormViewCellContainer {
        self.insets = insets
        return self
    }
    
    open func onSelect(_ handler: ((FormViewCellContainer) -> Void)?) -> FormViewCellContainer {
        onSelect = handler
        return self
    }
}