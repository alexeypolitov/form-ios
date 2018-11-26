//
//  ExtendedLabel.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit
import ZSWTappableLabel

open class ExtendedLabel: ZSWTappableLabel {

    public enum TextVerticalAlignment {
        case top
        case center
        case bottom
    }
    
    open var insets: UIEdgeInsets = UIEdgeInsets.zero
    open var textVerticalAlignment: TextVerticalAlignment = .center
    open var backgroundRectColor: UIColor?
    open var backgroundRectCornerRadius: CGFloat = 0
    
    open override func drawText(in rect: CGRect) {
        var newRect = rect
        
        if textVerticalAlignment == .top {
            newRect.size.height -= (newRect.height - intrinsicContentSize.height)
        } else if textVerticalAlignment == .bottom {
            let offset = newRect.height - intrinsicContentSize.height
            newRect.size.height -= offset
            newRect.origin.y = offset
        }
        
        if let context = UIGraphicsGetCurrentContext() {
            
            if let color = backgroundRectColor {
                context.setFillColor(color.cgColor)
                
                var x: CGFloat = 0
                var y: CGFloat = 0
                
                if textAlignment == .center {
                    x = rect.width / 2 - intrinsicContentSize.width / 2
                } else if textAlignment == .right {
                    x = rect.width - intrinsicContentSize.width
                }
                
                if textVerticalAlignment == .center {
                    y = rect.height / 2 - intrinsicContentSize.height / 2
                } else if textVerticalAlignment == .bottom {
                    y = rect.height - intrinsicContentSize.height
                }
                
                context.addPath(UIBezierPath(roundedRect: CGRect(x: x, y: y, width: intrinsicContentSize.width, height: intrinsicContentSize.height),
                                             cornerRadius: backgroundRectCornerRadius).cgPath)
                context.fillPath()
            }
            
        }
        
        super.drawText(in: newRect.inset(by: insets))
    }

    open override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += insets.left + insets.right
        size.height += insets.top + insets.bottom
        return size
    }
    
}
