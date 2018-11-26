//
//  ExtandedBarButtonItem.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/24.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class ExtandedUIBarButtonItem: UIBarButtonItem {
    
    open var onAction: ((ExtandedUIBarButtonItem) -> Void)?
    open func onAction(_ handler: ((ExtandedUIBarButtonItem) -> Void)?) {
        self.onAction = handler
    }

}

extension UIBarButtonItem {
    
    static func flexibleSpace() -> UIBarButtonItem  {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    }
    
    static func fixedSpace() -> UIBarButtonItem  {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
    }
}
