//
//  FormLabelStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormLabelControl: ExtendedLabel, FormControllable {
    
    var isMain: Bool
    let name: String
    var layoutDelegate: FormLayoutable?
    
    open override var text: String? {
        didSet {
            layoutDelegate?.updateControlLayout(element: self)
        }
    }
    
    open override var attributedText: NSAttributedString? {
        didSet {
            layoutDelegate?.updateControlLayout(element: self)
        }
    }
    
    public override init(frame: CGRect) {
        fatalError("Use init()")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init(_ name: String = UUID().uuidString,
         text: String? = nil,
         textVerticalAlignment: ExtendedLabel.TextVerticalAlignment = .center,
         textHorizontalAlignment: NSTextAlignment = .left,
         isMain: Bool = false
        )
    {
        self.name = name
        self.isMain = isMain
        
        super.init(frame: CGRect.zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.numberOfLines = 1
        self.textVerticalAlignment = textVerticalAlignment
        self.textAlignment = textHorizontalAlignment
        self.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    }
    
    func layoutDelegate(_ layoutDelegate: FormLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
}

// MARK: - Setters

extension FormLabelControl {
    
    func isMain(_ isMain: Bool) -> FormLabelControl {
        self.isMain = isMain
        return self
    }
    
    func textHorizontalAlignment(_ textAlignment: NSTextAlignment) -> FormLabelControl {
        self.textAlignment = textAlignment
        return self
    }
    
    func textVerticalAlignment(_ textAlignment: ExtendedLabel.TextVerticalAlignment) -> FormLabelControl {
        self.textVerticalAlignment = textAlignment
        return self
    }
    
    func text(_ text: String?) -> FormLabelControl {
        self.text = text
        return self
    }
    
    func attributedText(_ text: NSAttributedString?) -> FormLabelControl {
        self.attributedText = text
        return self
    }
    
    func font(_ font: UIFont) -> FormLabelControl {
        self.font = font
        return self
    }
    
    func numberOfLines(_ numberOfLines: Int) -> FormLabelControl {
        self.numberOfLines = numberOfLines
        return self
    }
    
    func backgroundColor(_ backgroundColor: UIColor?) -> FormLabelControl {
        self.backgroundColor = backgroundColor
        return self
    }
    
}
