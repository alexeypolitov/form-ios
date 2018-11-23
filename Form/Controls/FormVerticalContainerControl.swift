//
//  FormVerticalContainerControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

class FormVerticalContainerControl: UIView, FormControllable, FormBindable, FormSelectable, FormOnLoad {
    
    var isMain: Bool
    let name: String
    var layoutDelegate: FormLayoutable?
    var controls: [FormControllable] = []
    var insets: UIEdgeInsets = UIEdgeInsets.zero
    var minimalInset: CGFloat = 8

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
    
    func layoutDelegate(_ layoutDelegate: FormLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
    func buildLayout() {
        
        removeStoredConstrains()
        
        var lastControl: FormControllable?
        for (controlIndex, control) in controls.enumerated() {
            
            guard let controlView = control as? UIView else {
                fatalError("Unexpected class: \(String(describing: control.self))")
                continue
            }
            
            addSubview(controlView)
            
            storeConstrain(view: controlView, constrain: controlView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: insets.top))
            storeConstrain(view: controlView, constrain: controlView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: insets.bottom * -1))

            if let controlSizeable = control as? FormSizeable {
                if let fixedHeigth = controlSizeable.fixedHeigth {
                    storeConstrain(view: controlView, constrain: controlView.heightAnchor.constraint(equalToConstant: fixedHeigth))
                }
                if let fixedWidth = controlSizeable.fixedWidth {
                    storeConstrain(view: controlView, constrain: controlView.widthAnchor.constraint(equalToConstant: fixedWidth))
                }
            }

            if let lastControlView = lastControl as? UIView {
                storeConstrain(view: controlView, constrain: controlView.topAnchor.constraint(equalTo: lastControlView.bottomAnchor, constant: minimalInset))
            } else {
                storeConstrain(view: controlView, constrain: controlView.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.left))
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
                    storeConstrain(view: controlView, constrain: controlView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: insets.right * -1))
                }
            }

            lastControl = control
            
        }
        
    }
    
    // MARK: - Constains
    
    class StoredConstrain {
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
    
    var bindDelegate: FormViewBindDelegate?
    var bindName: String? {
        get {
            return nil
        }
        set {
            preconditionFailure("Could not be used on horizontal contsainer")
        }
    }
    
    func bindDelegate(_ bindDelegate: FormViewBindDelegate?) {
        self.bindDelegate = bindDelegate
    }
    
    func refreshBindValue() {
        for control in controls {
            guard let `bindable` = control as? FormBindable else { continue }
            bindable.refreshBindValue()
        }
    }
    
    // MARK: - FormSelectable
    
    var selectionStyle: UITableViewCell.SelectionStyle?
    var accessoryType: UITableViewCell.AccessoryType?
    var onSelect: ((FormCellContainer) -> Void)?
 
    // MARK: - FormOnLoad
    var onLoad: ((FormControllable) -> Void)?
    
    func prepareOnLoad() {
        for control in controls {
            if let `onLoad` = control as? FormOnLoad {
                onLoad.prepareOnLoad()
                onLoad.onLoad?(control)
            }
        }
    }
    
}

// MARK: - FormLayoutable

extension FormVerticalContainerControl: FormLayoutable {
    
    func updateControlLayout(element: FormControllable) {
        layoutDelegate?.updateControlLayout(element: element)
    }
    
}

// MARK: - FormSearchable

extension FormVerticalContainerControl: FormSearchable {
    
    func control(_ name: String) -> FormControllable? {
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
    
    func bindableControls(_ bindName: String) -> [FormBindable] {
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

// MARK: - FormValidatable

extension FormVerticalContainerControl: FormValidatable {
    
    func validate() -> (Bool, String?) {
        
        for control in controls {
            if let `control` = control as? FormValidatable {
                let (success, message) = `control`.validate()
                if !success {
                    return (success, message)
                }
            }
        }
        
        return (true, nil)
    }
    
}

// MARK: - FormViewBindDelegate

extension FormVerticalContainerControl: FormViewBindDelegate {
    
    func bindValueChanged(control: FormControllable, bindName: String, value: Any?) {
        bindDelegate?.bindValueChanged(control: control, bindName: bindName, value: value)
    }
    
    func bindValue(_ bindName: String) -> Any? {
        return bindDelegate?.bindValue(bindName)
    }
    
}

// MARK: - Setters

extension FormVerticalContainerControl {
    
    func isMain(_ isMain: Bool) -> FormVerticalContainerControl {
        self.isMain = isMain
        return self
    }
    
    func add(_ control: FormControllable) -> FormVerticalContainerControl {
        control.layoutDelegate(self)
        if let `bindable` = control as? FormBindable {
            bindable.bindDelegate(self)
        }
        self.controls.append(control)
        self.buildLayout()
        return self
    }
    
    func add(_ controls: [FormControllable]) -> FormVerticalContainerControl {
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
    
    func onSelect(_ handler: ((FormCellContainer) -> Void)?) -> FormVerticalContainerControl {
        self.onSelect = handler
        return self
    }
    
    func onLoad(_ handler: ((FormControllable) -> Void)?) -> FormVerticalContainerControl {
        self.onLoad = handler
        return self
    }
    
}
