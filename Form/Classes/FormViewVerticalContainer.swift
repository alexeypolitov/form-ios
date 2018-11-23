//
//  FormVerticalContainerControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewVerticalContainer: UIView, FormControllable, FormBindable, FormSelectable, FormOnLoad {
    
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
        
        removeFormConstrains()
        
        var lastControl: FormControllable?
        for (controlIndex, control) in controls.enumerated() {
            
            guard let controlView = control as? UIView else {
                fatalError("Unexpected class: \(String(describing: control.self))")
                continue
            }
            
            addSubview(controlView)
            
            addFormConstrain(view: controlView, constrain: controlView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: insets.top))
            addFormConstrain(view: controlView, constrain: controlView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: insets.bottom * -1))

            if let controlSizeable = control as? FormSizeable {
                if let fixedHeigth = controlSizeable.fixedHeigth {
                    addFormConstrain(view: controlView, constrain: controlView.heightAnchor.constraint(equalToConstant: fixedHeigth))
                }
                if let fixedWidth = controlSizeable.fixedWidth {
                    addFormConstrain(view: controlView, constrain: controlView.widthAnchor.constraint(equalToConstant: fixedWidth))
                }
            }

            if let lastControlView = lastControl as? UIView {
                addFormConstrain(view: controlView, constrain: controlView.topAnchor.constraint(equalTo: lastControlView.bottomAnchor, constant: minimalInset))
            } else {
                addFormConstrain(view: controlView, constrain: controlView.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.left))
            }

            if control.isMain {
                controlView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
            } else {
                controlView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
            }

            // is last
            if controls.count - 1 == controlIndex {
                if let controlSizeable = control as? FormSizeable, controlSizeable.fixedHeigth != nil {
                    // do noting
                } else {
                    addFormConstrain(view: controlView, constrain: controlView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: insets.right * -1))
                }
            }

            lastControl = control
            
        }
        
    }
    
    // MARK: - Constains
    
    public func addFormConstrain(view: UIView, constrain: NSLayoutConstraint, priority: UILayoutPriority? = nil) {
        if let `priority` = priority {
            constrain.priority = priority
        }
        constrain.isActive = true
    }
    
    public func removeFormConstrains() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
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

extension FormViewVerticalContainer: FormLayoutable {
    
    open func updateControlLayout(element: FormControllable) {
        layoutDelegate?.updateControlLayout(element: element)
    }
    
}

// MARK: - FormSearchable

extension FormViewVerticalContainer: FormSearchable {
    
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

extension FormViewVerticalContainer: FormViewBindDelegate {
    
    open func bindValueChanged(control: FormControllable, bindName: String, value: Any?) {
        bindDelegate?.bindValueChanged(control: control, bindName: bindName, value: value)
    }
    
    open func bindValue(_ bindName: String) -> Any? {
        return bindDelegate?.bindValue(bindName)
    }
    
}

// MARK: - FormContainerable

extension FormViewVerticalContainer: FormContainerable {
    
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

extension FormViewVerticalContainer {
    
    open func isMain(_ isMain: Bool) -> FormViewVerticalContainer {
        self.isMain = isMain
        return self
    }
    
    open func add(_ control: FormControllable) -> FormViewVerticalContainer {
        control.layoutDelegate(self)
        if let `bindable` = control as? FormBindable {
            bindable.bindDelegate(self)
        }
        self.controls.append(control)
        self.buildLayout()
        return self
    }
    
    open func add(_ controls: [FormControllable]) -> FormViewVerticalContainer {
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
    
    open func onSelect(_ handler: ((FormViewCellContainer) -> Void)?) -> FormViewVerticalContainer {
        self.onSelect = handler
        return self
    }
    
    open func onLoad(_ handler: ((FormControllable) -> Void)?) -> FormViewVerticalContainer {
        self.onLoad = handler
        return self
    }
    
}