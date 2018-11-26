//
//  FormVerticalContainerControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewVerticalContainer: UIView, FormViewControllable, FormViewBindable, FormViewSelectable, FormViewOnLoad {
    
    public var isMain: Bool = false
    public let name: String
    public var layoutDelegate: FormViewLayoutable?
    open var controls: [FormViewControllable] = [] {
        didSet {
            for control in controls {
                control.layoutDelegate(self)
                if let `bindable` = control as? FormViewBindable {
                    bindable.bindDelegate(self)
                }
            }
            buildLayout()
        }
    }
    open var insets: UIEdgeInsets = UIEdgeInsets.zero
    open var minimalInset: CGFloat = 8

    public init(_ name: String = UUID().uuidString, _ initializer: @escaping (FormViewVerticalContainer) -> Void = { _ in }) {
        self.name = name
        
        super.init(frame: CGRect.zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        initializer(self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    open func layoutDelegate(_ layoutDelegate: FormViewLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
    open func buildLayout() {
        
        removeFormConstrains()
        
        var lastControl: FormViewControllable?
        for (controlIndex, control) in controls.enumerated() {
            
            guard let controlView = control as? UIView else {
                fatalError("Unexpected class: \(String(describing: control.self))")
                continue
            }
            
            addSubview(controlView)
            
            addFormConstrain(view: controlView, constrain: controlView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: insets.top))
            addFormConstrain(view: controlView, constrain: controlView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: insets.bottom * -1))

            if let controlSizeable = control as? FormViewSizeable {
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
                if let controlSizeable = control as? FormViewSizeable, controlSizeable.fixedHeigth != nil {
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

    // MARK: - FormViewBindable
    
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
            guard let `bindable` = control as? FormViewBindable else { continue }
            bindable.refreshBindValue()
        }
    }
    
    // MARK: - FormViewSelectable
    
    open var selectionStyle: UITableViewCell.SelectionStyle?
    open var accessoryType: UITableViewCell.AccessoryType?
    open var onSelect: ((FormViewCellContainer) -> Void)?
 
    // MARK: - FormViewOnLoad
    open var onLoad: ((Any) -> Void)?
    
    open func prepareOnLoad() {
        for control in controls {
            if let `onLoad` = control as? FormViewOnLoad {
                onLoad.prepareOnLoad()
                onLoad.onLoad?(control)
            }
        }
    }
    
}

// MARK: - FormViewLayoutable

extension FormViewVerticalContainer: FormViewLayoutable {
    
    open func updateControlLayout(element: FormViewControllable) {
        layoutDelegate?.updateControlLayout(element: element)
    }
    
}

// MARK: - FormViewSearchable

extension FormViewVerticalContainer: FormViewSearchable {
    
    open func control(_ name: String) -> FormViewControllable? {
        for control in controls {
            if control.name == name {
                return control
            }
            if let `control` = control as? FormViewSearchable {
                if let result = control.control(name) {
                    return result
                }
            }
        }
        
        return nil
    }
    
    open func bindableControls(_ bindName: String) -> [FormViewBindable] {
        var list: [FormViewBindable] = []
        for control in controls {            
            if let `control` = control as? FormViewBindable {
                if control.bindName == bindName {
                    list.append(control)
                }
            }
            if let `control` = control as? FormViewSearchable {
                list.append(contentsOf: control.bindableControls(bindName))
            }
        }
        
        return list
    }
    
}

// MARK: - FormViewBindDelegate

extension FormViewVerticalContainer: FormViewBindDelegate {
    
    open func bindValueChanged(control: FormViewControllable, bindName: String, value: Any?) {
        bindDelegate?.bindValueChanged(control: control, bindName: bindName, value: value)
    }
    
    open func bindValue(_ bindName: String) -> Any? {
        return bindDelegate?.bindValue(bindName)
    }
    
}

// MARK: - FormViewContainerable

extension FormViewVerticalContainer: FormViewContainerable {
    
    // MARK: - Containerable
    open func controlsNames() -> [String] {
        var list: [String] = []
        for control in controls {
            list.append(control.name)
            if let `control` = control as? FormViewContainerable {
                list.append(contentsOf: control.controlsNames())
            }
        }
        return list        
    }
    
}
