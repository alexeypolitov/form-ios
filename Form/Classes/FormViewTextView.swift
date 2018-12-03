//
//  FormTextViewStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewTextView: ExtendedTextView, FormViewControllable, FormViewBindable, FormViewOnLoad, FormViewInputable, FormViewSizeable {
    
    public var isMain: Bool = false
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
    
    open override var text: String! {
        didSet {
            updateLayout()
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    public init(_ name: String = UUID().uuidString, _ initializer: @escaping (FormViewTextView) -> Void = { _ in }) {
        self.name = name
        
        super.init()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textContainerInset = UIEdgeInsets.zero
        self.textContainer.lineFragmentPadding = 0
        self.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.isScrollEnabled = false
        self.backgroundColor = UIColor.clear
        self.delegate = self        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        initializer(self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        
        text = bindValue
    }
    
    // MARK: - FormViewOnLoad
    open var onLoad: ((Any) -> Void)?
    
    // MARK: - FormViewInputable
    private var _inputSource: FormViewInputSource?
    public var inputSource: FormViewInputSource? {
        get {
            return _inputSource
        }
        set {
            _inputSource = newValue
            inputView = newValue?.inputView
            inputAccessoryView = newValue?.inputAccessoryView
        }
    }
    
    // MARK: - FormStackControlElementSizing
    
    private var _fixedWidth:CGFloat?
    open var fixedWidth: CGFloat? {
        get {
            return _fixedWidth
        }
        set {
            _fixedWidth = newValue
        }
    }
    private var _fixedHeigth:CGFloat?
    open var fixedHeigth: CGFloat? {
        get {
            return _fixedHeigth
        }
        set {
            _fixedHeigth = newValue
        }
    }
    private var _minimumHeight:CGFloat?
    open var minimumHeight: CGFloat? {
        get {
            return _minimumHeight
        }
        set {
            _minimumHeight = newValue
        }
    }
    private var _minimumWidth:CGFloat?
    open var minimumWidth: CGFloat? {
        get {
            return _minimumWidth
        }
        set {
            _minimumWidth = newValue
        }
    }
    
    // MARK: - Keyboard Notifications
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard isFirstResponder else { return}
        layoutDelegate?.inputSourceWillShow(notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard isFirstResponder else { return}        
        layoutDelegate?.inputSourceWillHide(notification)
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
