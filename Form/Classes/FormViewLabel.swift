//
//  FormLabelStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewLabel: ExtendedLabel, FormControllable, FormSelectable, FormBindable, FormOnLoad {
    
    public var isMain: Bool
    public let name: String
    public var layoutDelegate: FormLayoutable?

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
        if text != nil {
            self.text = text
        }        
        self.numberOfLines = 1
        self.textVerticalAlignment = textVerticalAlignment
        self.textAlignment = textHorizontalAlignment
        self.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    }
    
    open func layoutDelegate(_ layoutDelegate: FormLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
    // MARK: - FormSelectable
    
    open var selectionStyle: UITableViewCell.SelectionStyle?
    open var accessoryType: UITableViewCell.AccessoryType?
    open var onSelect: ((FormViewCellContainer) -> Void)?
    
    // MARK: - FormBindable
    
    open var bindDelegate: FormViewBindDelegate?
    open var bindName: String?
    
    open func bindDelegate(_ bindDelegate: FormViewBindDelegate?) {
        self.bindDelegate = bindDelegate
    }
    
    open func refreshBindValue() {
        guard let `bindDelegate` = bindDelegate, let `bindName` = bindName else { return }
        if let bindValue = bindDelegate.bindValue(bindName) as? String {
            let _ = text(bindValue)
        } else if let bindValue = bindDelegate.bindValue(bindName) as? NSAttributedString {
            let _ = attributedText(bindValue)
        }
    }
    
    // MARK: - FormOnLoad
    open var onLoad: ((FormControllable) -> Void)?
    
}

// MARK: - Setters

extension FormViewLabel {
    
    open func isMain(_ isMain: Bool) -> FormViewLabel {
        self.isMain = isMain
        return self
    }
    
    open func textHorizontalAlignment(_ textAlignment: NSTextAlignment) -> FormViewLabel {
        self.textAlignment = textAlignment
        return self
    }
    
    open func textVerticalAlignment(_ textAlignment: ExtendedLabel.TextVerticalAlignment) -> FormViewLabel {
        self.textVerticalAlignment = textAlignment
        return self
    }
    
    open func text(_ text: String?) -> FormViewLabel {
        self.text = text
        return self
    }
    
    open func attributedText(_ text: NSAttributedString?) -> FormViewLabel {
        self.attributedText = text
        return self
    }
    
    open func font(_ font: UIFont) -> FormViewLabel {
        self.font = font
        return self
    }
    
    open func numberOfLines(_ numberOfLines: Int) -> FormViewLabel {
        self.numberOfLines = numberOfLines
        return self
    }
    
    open func backgroundColor(_ backgroundColor: UIColor?) -> FormViewLabel {
        self.backgroundColor = backgroundColor
        return self
    }
    
    open func selectionStyle(_ selectionStyle: UITableViewCell.SelectionStyle?) -> FormViewLabel {
        self.selectionStyle = selectionStyle
        return self
    }
    
    open func accessoryType(_ accessoryType: UITableViewCell.AccessoryType?) -> FormViewLabel {
        self.accessoryType = accessoryType
        return self
    }
    
    open func onSelect(_ handler: ((FormViewCellContainer) -> Void)?) -> FormViewLabel {
        self.onSelect = handler
        return self
    }
    
    open func bind(_ bindName: String?) -> FormViewLabel {
        self.bindName = bindName
        return self
    }
    
    open func onLoad(_ handler: ((FormControllable) -> Void)?) -> FormViewLabel {
        self.onLoad = handler
        return self
    }
}