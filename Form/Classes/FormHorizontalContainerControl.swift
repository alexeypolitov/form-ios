//
//  FormHorizontalContainerControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormHorizontalContainerControl: UIView, FormControllable, FormBindable, FormSelectable, FormOnLoad {
    
    public var isMain: Bool
    public let name: String
    public var layoutDelegate: FormLayoutable?
    open var controls: [FormControllable] = []
    open var insets: UIEdgeInsets = UIEdgeInsets.zero
    open var minimalInset: CGFloat = 8
    
    init(_ name: String = UUID().uuidString, isMain: Bool = false) {
        self.name = name
        self.isMain = isMain
        
        super.init(frame: CGRect.zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    open func layoutDelegate(_ layoutDelegate: FormLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
    open func buildLayout() {
        
        removeStoredConstrains()
        
        var lastControl: FormControllable?
        for (controlIndex, control) in controls.enumerated() {
            
            guard let controlView = control as? UIView else {
                fatalError("Unexpected class: \(String(describing: control.self))")
                continue
            }
            
            addSubview(controlView)
            
            storeConstrain(view: controlView, constrain: controlView.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top))
            storeConstrain(view: controlView, constrain: controlView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: insets.bottom * -1))
            
            if let controlSizeable = control as? FormSizeable {
                if let fixedHeigth = controlSizeable.fixedHeigth {
                    storeConstrain(view: controlView, constrain: controlView.heightAnchor.constraint(equalToConstant: fixedHeigth))
                }
                if let fixedWidth = controlSizeable.fixedWidth {
                    storeConstrain(view: controlView, constrain: controlView.widthAnchor.constraint(equalToConstant: fixedWidth))
                }
            }
            
            if let lastControlView = lastControl as? UIView {
                storeConstrain(view: controlView, constrain: controlView.leftAnchor.constraint(equalTo: lastControlView.rightAnchor, constant: minimalInset))
            } else {
                storeConstrain(view: controlView, constrain: controlView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: insets.left))
            }
            
            if control.isMain {
                controlView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
            } else {
                controlView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
            }
            
            // is last
            if controls.count - 1 == controlIndex {
                if let controlSizeable = control as? FormSizeable, controlSizeable.fixedWidth != nil {
                    // do noting
                } else {
                    storeConstrain(view: controlView, constrain: controlView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: insets.right * -1))
                }
            }
            
            lastControl = control
            
        }
        
    }
    
    // MARK: - Constains
    
    private class StoredConstrain {
        let view: UIView
        var constrains: [NSLayoutConstraint]
        
        init(view: UIView, constrains: [NSLayoutConstraint]) {
            self.view = view
            self.constrains = constrains
        }
    }
    private var storedConstrains:[StoredConstrain] = []
    
    private func storeConstrain(view: UIView, constrain: NSLayoutConstraint) {
        constrain.isActive = true
//        if let stored = storedConstrains.first(where: {$0.view == view}) {
//            stored.constrains.append(constrain)
//        } else {
//            storedConstrains.append(StoredConstrain(view: view, constrains: [constrain]))
//        }
    }
    
    private func removeStoredConstrains() {
        
        for subview in subviews {
            subview.removeFromSuperview()
        }
//        for storedConstrain in storedConstrains {
//
//            for constrain in storedConstrain.constrains {
//                storedConstrain.view.removeConstraint(constrain)
//            }
//
//            if storedConstrain.view != self {
//                storedConstrain.view.removeFromSuperview()
//            }
//
//        }
//
//        storedConstrains = []
        
    }
    
    // MARK: - FormBindable
    
    open var bindDelegate: FormViewBindDelegate?
    open var bindName: String? {
        get {
            return nil
        }
        set {
          preconditionFailure("Could not be used on horizontal contsainer")
        }
    }
    
    open func bindDelegate(_ bindDelegate: FormViewBindDelegate?) {
        self.bindDelegate = bindDelegate
    }
    
    open func refreshBindValue() {
        for control in controls {
            guard let `bindable` = control as? FormBindable else { continue }
            bindable.refreshBindValue()
        }
    }
    
    // MARK: - FormSelectable
    
    open var selectionStyle: UITableViewCell.SelectionStyle?
    open var accessoryType: UITableViewCell.AccessoryType?
    open var onSelect: ((FormViewCellContainer) -> Void)?
    
    // MARK: - FormOnLoad
    open var onLoad: ((FormControllable) -> Void)?
    
    open func prepareOnLoad() {
        for control in controls {
            if let `onLoad` = control as? FormOnLoad {
                onLoad.prepareOnLoad()
                onLoad.onLoad?(control)
            }
        }
    }
    
}

// MARK: - FormLayoutable

extension FormHorizontalContainerControl: FormLayoutable {
    
    open func updateControlLayout(element: FormControllable) {
        layoutDelegate?.updateControlLayout(element: element)
    }
    
}

// MARK: - FormSearchable

extension FormHorizontalContainerControl: FormSearchable {
    
    open func control(_ name: String) -> FormControllable? {
        for control in controls {
            if control.name == name {
                return control
            }
            if let `control` = control as? FormSearchable {
                if let result = control.control(name) {
                    return result
                }
            }
        }
        
        return nil
    }
    
    open func bindableControls(_ bindName: String) -> [FormBindable] {
        var list: [FormBindable] = []
        for control in controls {
            if let `control` = control as? FormBindable {
                if control.bindName == bindName {
                    list.append(control)
                }
            }
            if let `control` = control as? FormSearchable {
                list.append(contentsOf: control.bindableControls(bindName))
            }
        }
        
        return list
    }
    
}

// MARK: - FormViewBindDelegate

extension FormHorizontalContainerControl: FormViewBindDelegate {

    open func bindValueChanged(control: FormControllable, bindName: String, value: Any?) {
        bindDelegate?.bindValueChanged(control: control, bindName: bindName, value: value)
    }

    open func bindValue(_ bindName: String) -> Any? {
        return bindDelegate?.bindValue(bindName)
    }

}

// MARK: - FormContainerable

extension FormHorizontalContainerControl: FormContainerable {
    
    // MARK: - Containerable
    open func controlsNames() -> [String] {
        var list: [String] = []
        for control in controls {
            list.append(control.name)
            if let `control` = control as? FormContainerable {
                list.append(contentsOf: control.controlsNames())
            }
        }
        return list
    }
    
}

// MARK: - Setters

extension FormHorizontalContainerControl {
    
    open func isMain(_ isMain: Bool) -> FormHorizontalContainerControl {
        self.isMain = isMain
        return self
    }
    
    open func add(_ control: FormControllable) -> FormHorizontalContainerControl {
        control.layoutDelegate(self)
        if let `bindable` = control as? FormBindable {
            bindable.bindDelegate(self)
        }
        self.controls.append(control)
        self.buildLayout()
        return self
    }
    
    open func add(_ controls: [FormControllable]) -> FormHorizontalContainerControl {
        for control in controls {
            control.layoutDelegate(self)
            if let `bindable` = control as? FormBindable {
                bindable.bindDelegate(self)
            }
        }
        self.controls.append(contentsOf: controls)
        self.buildLayout()
        return self
    }
    
    open func onSelect(_ handler: ((FormViewCellContainer) -> Void)?) -> FormHorizontalContainerControl {
        self.onSelect = handler
        return self
    }
    
    open func onLoad(_ handler: ((FormControllable) -> Void)?) -> FormHorizontalContainerControl {
        self.onLoad = handler
        return self
    }
    
}

