//
//  FormTextViewStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormTextViewControl: ExtendedTextView, FormControllable, FormBindable, FormOnLoad {
    
    var isMain: Bool
    let name: String
    var layoutDelegate: FormLayoutable?
    
    var onChange: ((FormTextViewControl, String?) -> Void)?
    var onEndEditing: ((FormTextViewControl) -> Void)?
    var onBeginEditing: ((FormTextViewControl) -> Void)?
    var onChangeSelection: ((FormTextViewControl) -> Void)?
    var shouldEndEditing: ((FormTextViewControl) -> Bool)?
    var shouldBeginEditing: ((FormTextViewControl) -> Bool)?
    var shouldChangeCharacters: ((FormTextViewControl, String?, NSRange, String) -> Bool)?
    var shouldInteractWithURL: ((FormTextViewControl, URL, NSRange, UITextItemInteraction) -> Bool)?
    var shouldInteractWithAttachment: ((FormTextViewControl, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool)?
    
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
    
    func layoutDelegate(_ layoutDelegate: FormLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
    open override func onTextDidChange(notification: Notification) {
        super.onTextDidChange(notification: notification)

        updateLayout()
    }
    
    func updateLayout() {
        let size = self.bounds.size
        let newSize = self.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        
        // Resize the cell only when cell's size is changed
        if size.height != newSize.height {
            layoutDelegate?.updateControlLayout(element: self)
        }
    }
    
    // MARK: - FormBindable
    
    var bindDelegate: FormViewBindDelegate?
    var bindName: String?
    
    func bindDelegate(_ bindDelegate: FormViewBindDelegate?) {
        self.bindDelegate = bindDelegate
    }
    
    func refreshBindValue() {
        guard let `bindDelegate` = bindDelegate, let `bindName` = bindName else { return }
        guard let bindValue = bindDelegate.bindValue(bindName) as? String else { return }
        
        let _ = text(bindValue)
    }
    
    // MARK: - FormOnLoad
    var onLoad: ((FormControllable) -> Void)?
}

// MARK: - Setters

extension FormTextViewControl {

    func isMain(_ isMain: Bool) -> FormTextViewControl {
        self.isMain = isMain
        return self
    }
    
    func textAlignment(_ textAlignment: NSTextAlignment) -> FormTextViewControl {
        self.textAlignment = textAlignment
        return self
    }
    
    func text(_ text: String?) -> FormTextViewControl {
        self.text = text
        updateLayout()
        return self
    }
    
    func font(_ font: UIFont) -> FormTextViewControl {
        self.font = font
        return self
    }
    
    func placeholder(_ placeholder: String) -> FormTextViewControl {
        self.placeholder = placeholder
        return self
    }
    
    func backgroundColor(_ backgroundColor: UIColor?) -> FormTextViewControl {
        self.backgroundColor = backgroundColor
        return self
    }
    
    func bind(_ bindName: String?) -> FormTextViewControl {
        self.bindName = bindName
        return self
    }
    
    func onLoad(_ handler: ((FormControllable) -> Void)?) -> FormTextViewControl {
        self.onLoad = handler
        return self
    }
    
    func onChange(_ handler: ((FormTextViewControl, String?) -> Void)?) -> FormTextViewControl {
        onChange = handler
        return self
    }
    func onEndEditing(_ handler: ((FormTextViewControl) -> Void)?) -> FormTextViewControl {
        onEndEditing = handler
        return self
    }

    func onBeginEditing(_ handler: ((FormTextViewControl) -> Void)?) -> FormTextViewControl {
        onBeginEditing = handler
        return self
    }

    func onChangeSelection(_ handler: ((FormTextViewControl) -> Void)?) -> FormTextViewControl {
        onChangeSelection = handler
        return self
    }
    
    func shouldEndEditing(_ handler: ((FormTextViewControl) -> Bool)?) -> FormTextViewControl {
        shouldEndEditing = handler
        return self
    }

    func shouldBeginEditing(_ handler: ((FormTextViewControl) -> Bool)?) -> FormTextViewControl {
        shouldBeginEditing = handler
        return self
    }

    func shouldChangeCharacters(_ handler: ((FormTextViewControl, String?, NSRange, String) -> Bool)?) -> FormTextViewControl {
        shouldChangeCharacters = handler
        return self
    }

    func shouldInteractWithURL(_ handler: ((FormTextViewControl, URL, NSRange, UITextItemInteraction) -> Bool)?) -> FormTextViewControl {
        shouldInteractWithURL = handler
        return self
    }

    func shouldInteractWithAttachment(_ handler: ((FormTextViewControl, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool)?) -> FormTextViewControl {
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
