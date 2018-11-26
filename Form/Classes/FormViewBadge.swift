//
//  FormBadgeStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewBadge: FormViewLabel {
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    public override init(_ name: String = UUID().uuidString, _ initializer: @escaping (FormViewBadge) -> Void = { _ in }) {
        super.init(name)
        
        self.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 2)
        self.numberOfLines = 0
        self.insets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        self.backgroundRectColor = UIColor.red
        self.backgroundRectCornerRadius = 5
        
        initializer(self)
    }
    
}
