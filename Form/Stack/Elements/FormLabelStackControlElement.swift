//
//  FormLabelStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormLabelStackControlElement: ExtendedLabel, FormStackControlElement {
    
    var isMain: Bool
    let name: String
    var stackDelegate: FormStackControlElementDelegate?
    var layoutDelegate: FormStackControlElementLayoutDelegate?
    
    open override var text: String? {
        didSet {
            stackDelegate?.updateControl()
            layoutDelegate?.updateControlLayout(element: self)
        }
    }
    
    open override var attributedText: NSAttributedString? {
        didSet {
            stackDelegate?.updateControl()
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
    
    func prepareStackDelegate(delegate: FormStackControlElementDelegate) {
        stackDelegate = delegate
    }
    
}

// MARK: - Setters

extension FormLabelStackControlElement {
    
    func isMain(_ isMain: Bool) -> FormLabelStackControlElement {
        self.isMain = isMain
        return self
    }
    
    func textHorizontalAlignment(_ textAlignment: NSTextAlignment) -> FormLabelStackControlElement {
        self.textAlignment = textAlignment
        return self
    }
    
    func textVerticalAlignment(_ textAlignment: ExtendedLabel.TextVerticalAlignment) -> FormLabelStackControlElement {
        self.textVerticalAlignment = textAlignment
        return self
    }
    
    func text(_ text: String?) -> FormLabelStackControlElement {
        self.text = text
        return self
    }
    
    func attributedText(_ text: NSAttributedString?) -> FormLabelStackControlElement {
        self.attributedText = text
        return self
    }
    
    func font(_ font: UIFont) -> FormLabelStackControlElement {
        self.font = font
        return self
    }
    
    func numberOfLines(_ numberOfLines: Int) -> FormLabelStackControlElement {
        self.numberOfLines = numberOfLines
        return self
    }
    
    func backgroundColor(_ backgroundColor: UIColor?) -> FormLabelStackControlElement {
        self.backgroundColor = backgroundColor
        return self
    }
    
}
