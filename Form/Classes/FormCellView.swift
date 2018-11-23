//
//  FormCellView.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormCellView: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func updateLayout() {
        onUpdateLayout()
    }
    
    open func onUpdateLayout() {
        // custom code
    }
    
    // MARK: - Constrains
    
    public class StoredConstrain {
        let view: UIView
        var constrains: [NSLayoutConstraint]
        
        init(view: UIView, constrains: [NSLayoutConstraint]) {
            self.view = view
            self.constrains = constrains
        }
    }
    
    private var storedConstrains: [StoredConstrain] = []
    
    public func storeConstrain(view: UIView, constrain: NSLayoutConstraint, priority: UILayoutPriority? = nil) {
        if let `priority` = priority {
            constrain.priority = priority
        }
        constrain.isActive = true
//        if let stored = storedConstrains.first(where: {$0.view == view}) {
//            stored.constrains.append(constrain)
//        } else {
//            storedConstrains.append(StoredConstrain(view: view, constrains: [constrain]))
//        }
    }
    
    public func removeStoredConstrains() {
        
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
//        for storedConstrain in storedConstrains {
//
//            for constrain in storedConstrain.constrains {
//                storedConstrain.view.removeConstraint(constrain)
//            }
//
//            if storedConstrain.view != self.contentView {
//                storedConstrain.view.removeFromSuperview()
//            }
//
//        }
//
//        storedConstrains = []
        
    }
    
}
