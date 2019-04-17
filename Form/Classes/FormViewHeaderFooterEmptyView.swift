//
//  FormViewHeaderFooterEmptyView.swift
//  Form
//
//  Created by Alexey Politov on 2019/04/17.
//  Copyright © 2019 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewHeaderFooterEmptyView: FormViewHeaderFooterView {
    
    open override func onUpdateLayout() {
        
        backgroundColor = UIColor.clear
        
        removeFormConstrains()
        addFormConstrain(view: self, constrain: heightAnchor.constraint(equalToConstant: 0.5), priority: .defaultHigh)
        
    }
    
}
