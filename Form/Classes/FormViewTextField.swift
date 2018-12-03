//
//  FormTextFieldStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewTextField: UITextField, FormViewControllable, FormViewBindable, FormViewOnLoad, FormViewInputable {
    
    public var isMain: Bool = false
    public let name: String
    public var layoutDelegate: FormViewLayoutable?
    
    open var onChange: ((FormViewTextField, String?) -> Void)?
    open var onBeginEditing: ((FormViewTextField) -> Void)?
    open var onEndEditing: ((FormViewTextField, UITextField.DidEndEditingReason) -> Void)?
    open var shouldBeginEditing: ((FormViewTextField) -> Bool)?
    open var shouldEndEditing: ((FormViewTextField) -> Bool)?
    open var shouldClear: ((FormViewTextField) -> Bool)?
    open var shouldReturn: ((FormViewTextField) -> Bool)?
    open var shouldChangeCharacters: ((FormViewTextField, String?, NSRange, String) -> Bool)?
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    public init(_ name: String = UUID().uuidString, _ initializer: @escaping (FormViewTextField) -> Void = { _ in }) {
        self.name = name
        
        super.init(frame: CGRect.zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.backgroundColor = UIColor.clear
        self.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onTextDidChange(notification:)), name: UITextField.textDidChangeNotification, object: self)
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

// MARK: - UITextFieldDelegate

extension FormViewTextField: UITextFieldDelegate {
    
    @objc open func onTextDidChange(notification: Notification) {
        onChange?(self, text)
        
        if let `bindName` = bindName {
            bindDelegate?.bindValueChanged(control: self, bindName: bindName, value: text)
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        onBeginEditing?(self)
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return shouldClear?(self) ?? false
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return shouldReturn?(self) ?? false
    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return shouldEndEditing?(self) ?? true
    }

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return shouldBeginEditing?(self) ?? true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        onEndEditing?(self, reason)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return shouldChangeCharacters?(self, textField.text, range, string) ?? true
    }
    
}
