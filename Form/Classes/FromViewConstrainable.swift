//
//  FromViewConstrainable.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/24.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

public protocol FromViewConstrainable {
    func addFormConstrain(view: UIView, constrain: NSLayoutConstraint, priority: UILayoutPriority?)
    func removeFormConstrains()
}

extension FromViewConstrainable {
    
//    public func addFormConstrain(view: UIView, constrain: NSLayoutConstraint, priority: UILayoutPriority? = nil) {
//        if let `priority` = priority {
//            constrain.priority = priority
//        }
//        constrain.isActive = true
//    }
//    
//    public func removeFormConstrains(_ contentView: UIView) {
//        for subview in contentView.subviews {
//            subview.removeFromSuperview()
//        }
//    }
}
