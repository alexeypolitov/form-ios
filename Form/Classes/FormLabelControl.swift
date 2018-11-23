//
//  FormLabelStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormLabelControl: ExtendedLabel, FormControllable, FormSelectable, FormBindable, FormOnLoad {
    
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
        if text != nil {
            self.text = text
        }        
        self.numberOfLines = 1
        self.textVerticalAlignment = textVerticalAlignment
        self.textAlignment = textHorizontalAlignment
        self.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    }
    
    func layoutDelegate(_ layoutDelegate: FormLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
    // MARK: - FormSelectable
    
    var selectionStyle: UITableViewCell.SelectionStyle?
    var accessoryType: UITableViewCell.AccessoryType?
    var onSelect: ((FormCellContainer) -> Void)?
    
    // MARK: - FormBindable
    
    var bindDelegate: FormViewBindDelegate?
    var bindName: String?
    
    func bindDelegate(_ bindDelegate: FormViewBindDelegate?) {
        self.bindDelegate = bindDelegate
    }
    
    func refreshBindValue() {
        guard let `bindDelegate` = bindDelegate, let `bindName` = bindName else { return }
        if let bindValue = bindDelegate.bindValue(bindName) as? String {
            let _ = text(bindValue)
        } else if let bindValue = bindDelegate.bindValue(bindName) as? NSAttributedString {
            let _ = attributedText(bindValue)
        }
    }
    
    // MARK: - FormOnLoad
    var onLoad: ((FormControllable) -> Void)?
    
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
    
    func selectionStyle(_ selectionStyle: UITableViewCell.SelectionStyle?) -> FormLabelControl {
        self.selectionStyle = selectionStyle
        return self
    }
    
    func accessoryType(_ accessoryType: UITableViewCell.AccessoryType?) -> FormLabelControl {
        self.accessoryType = accessoryType
        return self
    }
    
    func onSelect(_ handler: ((FormCellContainer) -> Void)?) -> FormLabelControl {
        self.onSelect = handler
        return self
    }
    
    func bind(_ bindName: String?) -> FormLabelControl {
        self.bindName = bindName
        return self
    }
    
    func onLoad(_ handler: ((FormControllable) -> Void)?) -> FormLabelControl {
        self.onLoad = handler
        return self
    }
}