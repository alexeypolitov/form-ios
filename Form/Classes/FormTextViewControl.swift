//
//  FormTextViewStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormTextViewControl: ExtendedTextView, FormControllable, FormBindable, FormOnLoad {
    
    public var isMain: Bool
    public let name: String
    public var layoutDelegate: FormLayoutable?
    
    open var onChange: ((FormTextViewControl, String?) -> Void)?
    open var onEndEditing: ((FormTextViewControl) -> Void)?
    open var onBeginEditing: ((FormTextViewControl) -> Void)?
    open var onChangeSelection: ((FormTextViewControl) -> Void)?
    open var shouldEndEditing: ((FormTextViewControl) -> Bool)?
    open var shouldBeginEditing: ((FormTextViewControl) -> Bool)?
    open var shouldChangeCharacters: ((FormTextViewControl, String?, NSRange, String) -> Bool)?
    open var shouldInteractWithURL: ((FormTextViewControl, URL, NSRange, UITextItemInteraction) -> Bool)?
    open var shouldInteractWithAttachment: ((FormTextViewControl, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool)?
    
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
    
    open func layoutDelegate(_ layoutDelegate: FormLayoutable?) {
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
    
    // MARK: - FormBindable
    
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
    
    // MARK: - FormOnLoad
    open var onLoad: ((FormControllable) -> Void)?
}

// MARK: - Setters

extension FormTextViewControl {

    open func isMain(_ isMain: Bool) -> FormTextViewControl {
        self.isMain = isMain
        return self
    }
    
    open func textAlignment(_ textAlignment: NSTextAlignment) -> FormTextViewControl {
        self.textAlignment = textAlignment
        return self
    }
    
    open func text(_ text: String?) -> FormTextViewControl {
        self.text = text
        updateLayout()
        return self
    }
    
    open func font(_ font: UIFont) -> FormTextViewControl {
        self.font = font
        return self
    }
    
    open func placeholder(_ placeholder: String) -> FormTextViewControl {
        self.placeholder = placeholder
        return self
    }
    
    open func backgroundColor(_ backgroundColor: UIColor?) -> FormTextViewControl {
        self.backgroundColor = backgroundColor
        return self
    }
    
    open func bind(_ bindName: String?) -> FormTextViewControl {
        self.bindName = bindName
        return self
    }
    
    open func onLoad(_ handler: ((FormControllable) -> Void)?) -> FormTextViewControl {
        self.onLoad = handler
        return self
    }
    
    open func onChange(_ handler: ((FormTextViewControl, String?) -> Void)?) -> FormTextViewControl {
        onChange = handler
        return self
    }
    
    open func onEndEditing(_ handler: ((FormTextViewControl) -> Void)?) -> FormTextViewControl {
        onEndEditing = handler
        return self
    }

    open func onBeginEditing(_ handler: ((FormTextViewControl) -> Void)?) -> FormTextViewControl {
        onBeginEditing = handler
        return self
    }

    open func onChangeSelection(_ handler: ((FormTextViewControl) -> Void)?) -> FormTextViewControl {
        onChangeSelection = handler
        return self
    }
    
    open func shouldEndEditing(_ handler: ((FormTextViewControl) -> Bool)?) -> FormTextViewControl {
        shouldEndEditing = handler
        return self
    }

    open func shouldBeginEditing(_ handler: ((FormTextViewControl) -> Bool)?) -> FormTextViewControl {
        shouldBeginEditing = handler
        return self
    }

    open func shouldChangeCharacters(_ handler: ((FormTextViewControl, String?, NSRange, String) -> Bool)?) -> FormTextViewControl {
        shouldChangeCharacters = handler
        return self
    }

    open func shouldInteractWithURL(_ handler: ((FormTextViewControl, URL, NSRange, UITextItemInteraction) -> Bool)?) -> FormTextViewControl {
        shouldInteractWithURL = handler
        return self
    }

    open func shouldInteractWithAttachment(_ handler: ((FormTextViewControl, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool)?) -> FormTextViewControl {
        shouldInteractWithAttachment = handler
        return self
    }

}

// MARK: - UITextViewDelegate

extension FormTextViewControl: UITextViewDelegate {
    
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
