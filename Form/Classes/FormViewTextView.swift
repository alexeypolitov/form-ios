//
//  FormTextViewStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewTextView: ExtendedTextView, FormViewControllable, FormViewBindable, FormViewOnLoad {
    
    public var isMain: Bool
    public let name: String
    public var layoutDelegate: FormViewLayoutable?
    
    open var onChange: ((FormViewTextView, String?) -> Void)?
    open var onEndEditing: ((FormViewTextView) -> Void)?
    open var onBeginEditing: ((FormViewTextView) -> Void)?
    open var onChangeSelection: ((FormViewTextView) -> Void)?
    open var shouldEndEditing: ((FormViewTextView) -> Bool)?
    open var shouldBeginEditing: ((FormViewTextView) -> Bool)?
    open var shouldChangeCharacters: ((FormViewTextView, String?, NSRange, String) -> Bool)?
    open var shouldInteractWithURL: ((FormViewTextView, URL, NSRange, UITextItemInteraction) -> Bool)?
    open var shouldInteractWithAttachment: ((FormViewTextView, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool)?
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init(_ name: String = UUID().uuidString,
         text: String? = nil,
         placeholder: String? = nil,
         isMultiline: Bool = true,
         isMain: Bool = false
        )
    {
        self.name = name
        self.isMain = isMain
        
        super.init()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.placeholder = placeholder
        self.textContainerInset = UIEdgeInsets.zero
        self.textContainer.lineFragmentPadding = 0
        self.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.isScrollEnabled = false
        self.backgroundColor = UIColor.clear
        self.delegate = self        
        
    }
    
    open func layoutDelegate(_ layoutDelegate: FormViewLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
    open override func onTextDidChange(notification: Notification) {
        super.onTextDidChange(notification: notification)

        updateLayout()
    }
    
    open func updateLayout() {
        let size = self.bounds.size
        let newSize = self.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        
        // Resize the cell only when cell's size is changed
        if size.height != newSize.height {
            layoutDelegate?.updateControlLayout(element: self)
        }
    }
    
    // MARK: - FormViewBindable
    
    open var bindDelegate: FormViewBindDelegate?
    open var bindName: String?
    
    open func bindDelegate(_ bindDelegate: FormViewBindDelegate?) {
        self.bindDelegate = bindDelegate
    }
    
    open func refreshBindValue() {
        guard let `bindDelegate` = bindDelegate, let `bindName` = bindName else { return }
        guard let bindValue = bindDelegate.bindValue(bindName) as? String else { return }
        
        let _ = text(bindValue)
    }
    
    // MARK: - FormViewOnLoad
    open var onLoad: ((FormViewControllable) -> Void)?
}

// MARK: - Setters

extension FormViewTextView {

    open func isMain(_ isMain: Bool) -> FormViewTextView {
        self.isMain = isMain
        return self
    }
    
    open func textAlignment(_ textAlignment: NSTextAlignment) -> FormViewTextView {
        self.textAlignment = textAlignment
        return self
    }
    
    open func text(_ text: String?) -> FormViewTextView {
        self.text = text
        updateLayout()
        return self
    }
    
    open func font(_ font: UIFont) -> FormViewTextView {
        self.font = font
        return self
    }
    
    open func placeholder(_ placeholder: String) -> FormViewTextView {
        self.placeholder = placeholder
        return self
    }
    
    open func backgroundColor(_ backgroundColor: UIColor?) -> FormViewTextView {
        self.backgroundColor = backgroundColor
        return self
    }
    
    open func keyboardType(_ keyboardType: UIKeyboardType) -> FormViewTextView {
        self.keyboardType = keyboardType
        return self
    }
    
    open func returnKeyType(_ returnKeyType: UIReturnKeyType) -> FormViewTextView {
        self.returnKeyType = returnKeyType
        return self
    }
    
    open func isSecureTextEntry(_ isSecureTextEntry: Bool) -> FormViewTextView {
        self.isSecureTextEntry = isSecureTextEntry
        return self
    }
    
    open func bind(_ bindName: String?) -> FormViewTextView {
        self.bindName = bindName
        return self
    }
    
    open func onLoad(_ handler: ((FormViewControllable) -> Void)?) -> FormViewTextView {
        self.onLoad = handler
        return self
    }
    
    open func onChange(_ handler: ((FormViewTextView, String?) -> Void)?) -> FormViewTextView {
        onChange = handler
        return self
    }
    
    open func onEndEditing(_ handler: ((FormViewTextView) -> Void)?) -> FormViewTextView {
        onEndEditing = handler
        return self
    }

    open func onBeginEditing(_ handler: ((FormViewTextView) -> Void)?) -> FormViewTextView {
        onBeginEditing = handler
        return self
    }

    open func onChangeSelection(_ handler: ((FormViewTextView) -> Void)?) -> FormViewTextView {
        onChangeSelection = handler
        return self
    }
    
    open func shouldEndEditing(_ handler: ((FormViewTextView) -> Bool)?) -> FormViewTextView {
        shouldEndEditing = handler
        return self
    }

    open func shouldBeginEditing(_ handler: ((FormViewTextView) -> Bool)?) -> FormViewTextView {
        shouldBeginEditing = handler
        return self
    }

    open func shouldChangeCharacters(_ handler: ((FormViewTextView, String?, NSRange, String) -> Bool)?) -> FormViewTextView {
        shouldChangeCharacters = handler
        return self
    }

    open func shouldInteractWithURL(_ handler: ((FormViewTextView, URL, NSRange, UITextItemInteraction) -> Bool)?) -> FormViewTextView {
        shouldInteractWithURL = handler
        return self
    }

    open func shouldInteractWithAttachment(_ handler: ((FormViewTextView, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool)?) -> FormViewTextView {
        shouldInteractWithAttachment = handler
        return self
    }

}

// MARK: - UITextViewDelegate

extension FormViewTextView: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        onChange?(self, text)
        
        if let `bindName` = bindName {
            bindDelegate?.bindValueChanged(control: self, bindName: bindName, value: text)
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        onEndEditing?(self)
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        onBeginEditing?(self)
    }
    
    public func textViewDidChangeSelection(_ textView: UITextView) {
        onChangeSelection?(self)
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return shouldEndEditing?(self) ?? true
    }

    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return shouldBeginEditing?(self) ?? true
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return shouldChangeCharacters?(self, textView.text, range, text) ?? true
    }

    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return shouldInteractWithURL?(self, URL, characterRange, interaction) ?? true
    }

    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return shouldInteractWithAttachment?(self, textAttachment, characterRange, interaction) ?? true
    }

}
