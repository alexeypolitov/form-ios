//
//  FormCellContainer.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewCellContainer: FormViewCell, FormViewCellSelectable, FormViewOnLoad {

    open override var viewClass: FormViewCellView.Type { return FormViewCellContainerView.self }
    open var control: FormViewControllable? {
        didSet {
            self.control?.layoutDelegate = self
            if let bindable = control as? FormViewBindable {
                bindable.bindDelegate(self)
            }   
        }
    }
    open var insets: UIEdgeInsets = UIEdgeInsets.zero
    open var minimalInset: CGFloat = 8
    
    public override init(_ name: String = UUID().uuidString, _ initializer: @escaping (FormViewCellContainer) -> Void = { _ in }) {
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
            } else if let `control` = control as? FormViewSelectable, let `onSelect` = control.onSelect {
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
            } else if let `control` = control as? FormViewSelectable, let `selectionStyle` = control.selectionStyle {
                return selectionStyle
            } else if let _ = onSelect {
                return .default
            } else if let `control` = control as? FormViewSelectable, let _ = control.onSelect {
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
            } else if let `control` = control as? FormViewSelectable, let `accessoryType` = control.accessoryType {
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
    
    // MARK: - FormViewOnLoad
    open var onLoad: ((Any) -> Void)?
}

// MARK: - FormViewContainerable

extension FormViewCellContainer: FormViewContainerable {
    
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

// MARK: - FormCellContainerViewDataSource

extension FormViewCellContainer: FormViewCellContainerViewDataSource {
    
    open func formViewCellContainerViewControl(_ view: FormViewCellContainerView) -> FormViewControllable? {
        return control
    }
    
    open func formViewCellContainerViewInsets(_ view: FormViewCellContainerView) -> UIEdgeInsets? {
        return insets
    }
    
}

// MARK: - FormViewLayoutable

extension FormViewCellContainer: FormViewLayoutable {
    
    open func updateControlLayout(element: FormViewControllable) {
        updateFormView()
    }
    
}

// MARK: - FormViewSearchable

extension FormViewCellContainer: FormViewSearchable {
    
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

extension FormViewCellContainer: FormViewBindDelegate {
    
    open func bindValueChanged(control: FormViewControllable, bindName: String, value: Any?) {
        formView?.bindValueChanged(control: control, bindName: bindName, value: value)
    }    
    
    open func bindValue(_ bindName: String) -> Any? {
        return formView?.bindValue(bindName)
    }
    
}

//// MARK: - Setters
//
//extension FormViewCellContainer {
//
//    open func control(_ control: FormViewControllable?) -> FormViewCellContainer {
//        self.control = control
//        self.control?.layoutDelegate = self
//        if let bindable = control as? FormViewBindable {
//            bindable.bindDelegate(self)
//        }
//        return self
//    }
//
//    open func insets(_ insets: UIEdgeInsets) -> FormViewCellContainer {
//        self.insets = insets
//        return self
//    }
//
//    open func onSelect(_ handler: ((FormViewCellContainer) -> Void)?) -> FormViewCellContainer {
//        onSelect = handler
//        return self
//    }
//
//    open func onLoad(_ handler: ((Any) -> Void)?) -> FormViewCellContainer {
//        self.onLoad = handler
//        return self
//    }
//}
