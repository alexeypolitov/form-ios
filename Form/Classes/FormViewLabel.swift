//
//  FormLabelStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewLabel: ExtendedLabel, FormViewControllable, FormViewSelectable, FormViewBindable, FormViewOnLoad, FormViewInputable {
    
    public var isMain: Bool
    public let name: String
    public var layoutDelegate: FormViewLayoutable?

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
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:))))
    }
    
    open func layoutDelegate(_ layoutDelegate: FormViewLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
    // MARK: - FormViewSelectable
    
    open var selectionStyle: UITableViewCell.SelectionStyle?
    open var accessoryType: UITableViewCell.AccessoryType?
    open var onSelect: ((FormViewCellContainer) -> Void)?
    
    // MARK: - FormViewBindable
    
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
    
    // MARK: - FormViewOnLoad
    open var onLoad: ((FormViewControllable) -> Void)?
    
    // MARK: - FormViewInputable
    private var _inputSource: FormViewInputSource?
    public var inputSource: FormViewInputSource? {
        get {
            return _inputSource
        }
        set {
            if let `newValue` = newValue {
                if newValue.inputView != nil {
                    _inputSource = newValue
                    isUserInteractionEnabled = true
                } else {
                    print("Error: \(String(describing: self)) expect not nil inputAccessoryView")
                }
            } else {
                _inputSource = nil
                isUserInteractionEnabled = false
            }
        }
    }
    
    open override var canBecomeFirstResponder: Bool {
        return inputSource != nil
    }
    
    open override var inputAccessoryView: UIView? {
        return inputSource?.inputAccessoryView
    }
    
    open override var inputView: UIView? {
        return inputSource?.inputView
    }
    
    @objc private func onTap(_ sender:Any) {
        becomeFirstResponder()
    }
    
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
    
    open func onLoad(_ handler: ((FormViewControllable) -> Void)?) -> FormViewLabel {
        self.onLoad = handler
        return self
    }
    
    open func inputSource(_ inputSource: FormViewInputSource?) -> FormViewLabel {
        self.inputSource = inputSource
        return self
    }
}
