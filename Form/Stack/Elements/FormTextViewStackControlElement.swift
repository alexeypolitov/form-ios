//
//  FormTextViewStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormTextViewStackControlElement: ExtendedTextView, FormStackControlElement {
    
    var isMain: Bool
    let name: String
    var stackDelegate: FormStackControlElementDelegate?
    var layoutDelegate: FormStackControlElementLayoutDelegate?
    
    var onChange: ((FormTextViewStackControlElement, String?) -> Void)?
    var onEndEditing: ((FormTextViewStackControlElement) -> Void)?
    var onBeginEditing: ((FormTextViewStackControlElement) -> Void)?
    var onChangeSelection: ((FormTextViewStackControlElement) -> Void)?
    var shouldEndEditing: ((FormTextViewStackControlElement) -> Bool)?
    var shouldBeginEditing: ((FormTextViewStackControlElement) -> Bool)?
    var shouldChangeCharacters: ((FormTextViewStackControlElement, String?, NSRange, String) -> Bool)?
    var shouldInteractWithURL: ((FormTextViewStackControlElement, URL, NSRange, UITextItemInteraction) -> Bool)?
    var shouldInteractWithAttachment: ((FormTextViewStackControlElement, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool)?
    
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
        self.delegate = self        
        
    }
    
    func prepareStackDelegate(delegate: FormStackControlElementDelegate) {
        stackDelegate = delegate
    }
    
    open override func onTextDidChange(notification: Notification) {
        super.onTextDidChange(notification: notification)

        let size = self.bounds.size
        let newSize = self.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))

        // Resize the cell only when cell's size is changed
        if size.height != newSize.height {
            self.stackDelegate?.updateControl()
        }

    }
    
}

// MARK: - Setters

extension FormTextViewStackControlElement {

    func isMain(_ isMain: Bool) -> FormTextViewStackControlElement {
        self.isMain = isMain
        return self
    }
    
    func textAlignment(_ textAlignment: NSTextAlignment) -> FormTextViewStackControlElement {
        self.textAlignment = textAlignment
        return self
    }
    
    func text(_ text: String?) -> FormTextViewStackControlElement {
        self.text = text
        return self
    }
    
    func font(_ font: UIFont) -> FormTextViewStackControlElement {
        self.font = font
        return self
    }
    
    func placeholder(_ placeholder: String) -> FormTextViewStackControlElement {
        self.placeholder = placeholder
        return self
    }
    
    func onChange(_ handler: ((FormTextViewStackControlElement, String?) -> Void)?) -> FormTextViewStackControlElement {
        onChange = handler
        return self
    }
    func onEndEditing(_ handler: ((FormTextViewStackControlElement) -> Void)?) -> FormTextViewStackControlElement {
        onEndEditing = handler
        return self
    }

    func onBeginEditing(_ handler: ((FormTextViewStackControlElement) -> Void)?) -> FormTextViewStackControlElement {
        onBeginEditing = handler
        return self
    }

    func onChangeSelection(_ handler: ((FormTextViewStackControlElement) -> Void)?) -> FormTextViewStackControlElement {
        onChangeSelection = handler
        return self
    }
    
    func shouldEndEditing(_ handler: ((FormTextViewStackControlElement) -> Bool)?) -> FormTextViewStackControlElement {
        shouldEndEditing = handler
        return self
    }

    func shouldBeginEditing(_ handler: ((FormTextViewStackControlElement) -> Bool)?) -> FormTextViewStackControlElement {
        shouldBeginEditing = handler
        return self
    }

    func shouldChangeCharacters(_ handler: ((FormTextViewStackControlElement, String?, NSRange, String) -> Bool)?) -> FormTextViewStackControlElement {
        shouldChangeCharacters = handler
        return self
    }

    func shouldInteractWithURL(_ handler: ((FormTextViewStackControlElement, URL, NSRange, UITextItemInteraction) -> Bool)?) -> FormTextViewStackControlElement {
        shouldInteractWithURL = handler
        return self
    }

    func shouldInteractWithAttachment(_ handler: ((FormTextViewStackControlElement, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool)?) -> FormTextViewStackControlElement {
        shouldInteractWithAttachment = handler
        return self
    }

}

// MARK: - UITextViewDelegate

extension FormTextViewStackControlElement: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        onChange?(self, textView.text.count > 0 ? textView.text : nil)
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
