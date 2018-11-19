//
//  FormBadgeStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormBadgeControl: FormLabelControl {
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init(_ name: String = UUID().uuidString,
         text: String? = nil,
         color: UIColor = UIColor.red,
         cornerRadius: CGFloat = 5,
         inserts: UIEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4),
         textVerticalAlignment: ExtendedLabel.TextVerticalAlignment = .center,
         textHorizontalAlignment: NSTextAlignment = .left,
         isMain: Bool = false
        )
    {
        super.init(name, text: text, textVerticalAlignment: textVerticalAlignment, textHorizontalAlignment: textHorizontalAlignment, isMain: isMain)
        
        self.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 2)
        self.numberOfLines = 0
        self.insets = inserts
        self.backgroundRectColor = color
        self.backgroundRectCornerRadius = cornerRadius
        
    }
    
}
