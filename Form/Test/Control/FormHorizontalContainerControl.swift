//
//  FormHorizontalContainerControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

class FormHorizontalContainerControl: UIView, FormControllable {
    
    var isMain: Bool
    let name: String
    var layoutDelegate: FormStackControlElementLayoutDelegate?
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
    
    func layoutDelegate(_ layoutDelegate: FormStackControlElementLayoutDelegate?) {
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
        if let stored = storedConstrains.first(where: {$0.view == view}) {
            stored.constrains.append(constrain)
        } else {
            storedConstrains.append(StoredConstrain(view: view, constrains: [constrain]))
        }
    }
    
    private func removeStoredConstrains() {
        
        for storedConstrain in storedConstrains {
            
            for constrain in storedConstrain.constrains {
                storedConstrain.view.removeConstraint(constrain)
            }
            
            if storedConstrain.view != self {
                storedConstrain.view.removeFromSuperview()
            }
            
        }
        
        storedConstrains = []
        
    }
    
    
}

// MARK: - Setters

extension FormHorizontalContainerControl {
    
    func isMain(_ isMain: Bool) -> FormHorizontalContainerControl {
        self.isMain = isMain
        return self
    }
    
    func add(_ control: FormControllable) -> FormHorizontalContainerControl {
        self.controls.append(control)
        self.buildLayout()
        return self
    }
    
    func add(_ controls: [FormControllable]) -> FormHorizontalContainerControl {
        self.controls.append(contentsOf: controls)
        self.buildLayout()
        return self
    }
    
}

