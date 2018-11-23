//
//  FormCellContainer.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

class FormCellContainer: FormCell, FormCellSelectable {

    override var viewClass: FormCellView.Type { return FormCellContainerView.self }
    var control: FormControllable?
    var insets: UIEdgeInsets = UIEdgeInsets.zero
    var minimalInset: CGFloat = 8
    
    override init(_ name: String = UUID().uuidString) {
        super.init(name)
        
        self.insets = FormCellContainer.appearance.insets
    }
    
    override func onPrepare() {
        if let `bindable` = control as? FormBindable {
            bindable.refreshBindValue()
        }
        
        if let `onLoad` = control as? FormOnLoad, let control = control {
            onLoad.prepareOnLoad()
            onLoad.onLoad?(control)
        }
        
        guard let `linkedView` = linkedView as? FormCellContainerView else { return }        
        linkedView.dataSource = self
    }
    
    class Appearance {
        var insets: UIEdgeInsets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
    }
    
    static let appearance = Appearance()
    
    // MARK: - FormCellSelectable
    
    private var _onSelect: ((FormCellContainer) -> Void)?
    var onSelect: ((FormCellContainer) -> Void)? {
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
    var selectionStyle: UITableViewCell.SelectionStyle? {
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
    var accessoryType: UITableViewCell.AccessoryType? {
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
    
    func formCellOnSelect() {
        onSelect?(self)
    }
    
}

// MARK: - FormContainerable

extension FormCellContainer: FormContainerable {
    
    // MARK: - Containerable
    func controlsNames() -> [String] {
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

extension FormCellContainer: FormCellContainerViewDataSource {
    
    func formCellContainerViewControl(_ view: FormCellContainerView) -> FormControllable? {
        return control
    }
    
    func formCellContainerViewInsets(_ view: FormCellContainerView) -> UIEdgeInsets? {
        return insets
    }
    
}

// MARK: - FormLayoutable

extension FormCellContainer: FormLayoutable {
    
    func updateControlLayout(element: FormControllable) {
        updateFormView()
    }
    
}

// MARK: - FormSearchable

extension FormCellContainer: FormSearchable {
    
    func control(_ name: String) -> FormControllable? {
        if control?.name == name {
            return control
        }
        if let `control` = control as? FormSearchable {
            return control.control(name)
        }
        return nil
    }
    
    func bindableControls(_ bindName: String) -> [FormBindable] {
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

// MARK: - FormValidatable

extension FormCellContainer: FormValidatable {
    
    func validate() -> (Bool, String?) {
        
        if let `control` = control as? FormValidatable {
            return control.validate()
        }
        
        return (true, nil)
    }
    
}

// MARK: - FormViewBindDelegate

extension FormCellContainer: FormViewBindDelegate {
    
    func bindValueChanged(control: FormControllable, bindName: String, value: Any?) {
        formView?.bindValueChanged(control: control, bindName: bindName, value: value)
    }    
    
    func bindValue(_ bindName: String) -> Any? {
        return formView?.bindValue(bindName)
    }
    
}

// MARK: - Setters

extension FormCellContainer {
    
    func control(_ control: FormControllable?) -> FormCellContainer {
        self.control = control
        self.control?.layoutDelegate = self
        if let bindable = control as? FormBindable {
            bindable.bindDelegate(self)
        }        
        return self
    }
    
    func insets(_ insets: UIEdgeInsets) -> FormCellContainer {
        self.insets = insets
        return self
    }
    
    func onSelect(_ handler: ((FormCellContainer) -> Void)?) -> FormCellContainer {
        onSelect = handler
        return self
    }
}
