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
    
    override func onPrepare(_ view: FormCellView) {
        guard let `view` = view as? FormCellContainerView else { return }
        
        view.dataSource = self
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

// MARK: - FormBindDelegate

extension FormCellContainer: FormBindDelegate {
    
    func bindValueChanged(bindName: String, value: Any?) {
        formView?.bindValueChanged(bindName: bindName, value: value)
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
