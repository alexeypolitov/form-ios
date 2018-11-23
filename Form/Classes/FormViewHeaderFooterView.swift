//
//  FormHeaderFooterView.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewHeaderFooterView: UITableViewHeaderFooterView {
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
    
    public func addFormConstrain(view: UIView, constrain: NSLayoutConstraint, priority: UILayoutPriority? = nil) {
        if let `priority` = priority {
            constrain.priority = priority
        }
        constrain.isActive = true
    }
    
    public func removeFormConstrains() {
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
    }
}

