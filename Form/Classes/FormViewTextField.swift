//
//  FormTextFieldStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewTextField: UITextField, FormControllable, FormBindable, FormOnLoad {
    
    public var isMain: Bool
    public let name: String
    public var layoutDelegate: FormLayoutable?
    
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
    
    init(_ name: String = UUID().uuidString,
         text: String? = nil,
         placeholder: String? = nil,
         isMain: Bool = false
        )
    {
        self.name = name
        self.isMain = isMain
        
        super.init(frame: CGRect.zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.placeholder = placeholder
        self.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.backgroundColor = UIColor.clear
        self.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onTextDidChange(notification:)), name: UITextField.textDidChangeNotification, object: self)
        
    }
    
    open func layoutDelegate(_ layoutDelegate: FormLayoutable?) {
        self.layoutDelegate = layoutDelegate
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

extension FormViewTextField {
    
    open func isMain(_ isMain: Bool) -> FormViewTextField {
        self.isMain = isMain
        return self
    }
    
    open func textAlignment(_ textAlignment: NSTextAlignment) -> FormViewTextField {
        self.textAlignment = textAlignment
        return self
    }
    
    open func text(_ text: String?) -> FormViewTextField {
        self.text = text
        return self
    }
    
    open func font(_ font: UIFont) -> FormViewTextField {
        self.font = font
        return self
    }
    
    open func placeholder(_ placeholder: String) -> FormViewTextField {
        self.placeholder = placeholder
        return self
    }
    
    open func backgroundColor(_ backgroundColor: UIColor?) -> FormViewTextField {
        self.backgroundColor = backgroundColor
        return self
    }
    
    open func keyboardType(_ keyboardType: UIKeyboardType) -> FormViewTextField {
        self.keyboardType = keyboardType
        return self
    }
    
    open func returnKeyType(_ returnKeyType: UIReturnKeyType) -> FormViewTextField {
        self.returnKeyType = returnKeyType
        return self
    }
    
    open func isSecureTextEntry(_ isSecureTextEntry: Bool) -> FormViewTextField {
        self.isSecureTextEntry = isSecureTextEntry
        return self
    }
    
    open func onChange(_ handler: ((FormViewTextField, String?) -> Void)?) -> FormViewTextField {
        onChange = handler
        return self
    }
    
    open func bind(_ bindName: String?) -> FormViewTextField {
        self.bindName = bindName
        return self
    }
    
    open func onLoad(_ handler: ((FormControllable) -> Void)?) -> FormViewTextField {
        self.onLoad = handler
        return self
    }
    
    open func onBeginEditing(_ handler: ((FormViewTextField) -> Void)?) -> FormViewTextField {
        onBeginEditing = handler
        return self
    }
    
    open func onEndEditing(_ handler: ((FormViewTextField, UITextField.DidEndEditingReason) -> Void)?) -> FormViewTextField {
        onEndEditing = handler
        return self
    }
    
    open func shouldBeginEditing(_ handler: ((FormViewTextField) -> Bool)?) -> FormViewTextField {
        shouldBeginEditing = handler
        return self
    }
    
    open func shouldEndEditing(_ handler: ((FormViewTextField) -> Bool)?) -> FormViewTextField {
        shouldEndEditing = handler
        return self
    }
    
    open func shouldChangeCharacters(_ handler: ((FormViewTextField, String?, NSRange, String) -> Bool)?) -> FormViewTextField {
        shouldChangeCharacters = handler
        return self
    }
    
    open func shouldClear(_ handler: ((FormViewTextField) -> Bool)?) -> FormViewTextField {
        shouldClear = handler
        return self
    }
    
    open func shouldReturn(_ handler: ((FormViewTextField) -> Bool)?) -> FormViewTextField {
        shouldReturn = handler
        return self
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
