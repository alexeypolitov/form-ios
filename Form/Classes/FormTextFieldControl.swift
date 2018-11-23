//
//  FormTextFieldStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormTextFieldControl: UITextField, FormControllable, FormBindable, FormOnLoad {
    
    public var isMain: Bool
    public let name: String
    public var layoutDelegate: FormLayoutable?
    
    open var onChange: ((FormTextFieldControl, String?) -> Void)?
    open var onBeginEditing: ((FormTextFieldControl) -> Void)?
    open var onEndEditing: ((FormTextFieldControl, UITextField.DidEndEditingReason) -> Void)?
    open var shouldBeginEditing: ((FormTextFieldControl) -> Bool)?
    open var shouldEndEditing: ((FormTextFieldControl) -> Bool)?
    open var shouldClear: ((FormTextFieldControl) -> Bool)?
    open var shouldReturn: ((FormTextFieldControl) -> Bool)?
    open var shouldChangeCharacters: ((FormTextFieldControl, String?, NSRange, String) -> Bool)?
    
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

extension FormTextFieldControl {
    
    open func isMain(_ isMain: Bool) -> FormTextFieldControl {
        self.isMain = isMain
        return self
    }
    
    open func textAlignment(_ textAlignment: NSTextAlignment) -> FormTextFieldControl {
        self.textAlignment = textAlignment
        return self
    }
    
    open func text(_ text: String?) -> FormTextFieldControl {
        self.text = text
        return self
    }
    
    open func font(_ font: UIFont) -> FormTextFieldControl {
        self.font = font
        return self
    }
    
    open func placeholder(_ placeholder: String) -> FormTextFieldControl {
        self.placeholder = placeholder
        return self
    }
    
    open func backgroundColor(_ backgroundColor: UIColor?) -> FormTextFieldControl {
        self.backgroundColor = backgroundColor
        return self
    }
    
    open func keyboardType(_ keyboardType: UIKeyboardType) -> FormTextFieldControl {
        self.keyboardType = keyboardType
        return self
    }
    
    open func returnKeyType(_ returnKeyType: UIReturnKeyType) -> FormTextFieldControl {
        self.returnKeyType = returnKeyType
        return self
    }
    
    open func isSecureTextEntry(_ isSecureTextEntry: Bool) -> FormTextFieldControl {
        self.isSecureTextEntry = isSecureTextEntry
        return self
    }
    
    open func onChange(_ handler: ((FormTextFieldControl, String?) -> Void)?) -> FormTextFieldControl {
        onChange = handler
        return self
    }
    
    open func bind(_ bindName: String?) -> FormTextFieldControl {
        self.bindName = bindName
        return self
    }
    
    open func onLoad(_ handler: ((FormControllable) -> Void)?) -> FormTextFieldControl {
        self.onLoad = handler
        return self
    }
    
    open func onBeginEditing(_ handler: ((FormTextFieldControl) -> Void)?) -> FormTextFieldControl {
        onBeginEditing = handler
        return self
    }
    
    open func onEndEditing(_ handler: ((FormTextFieldControl, UITextField.DidEndEditingReason) -> Void)?) -> FormTextFieldControl {
        onEndEditing = handler
        return self
    }
    
    open func shouldBeginEditing(_ handler: ((FormTextFieldControl) -> Bool)?) -> FormTextFieldControl {
        shouldBeginEditing = handler
        return self
    }
    
    open func shouldEndEditing(_ handler: ((FormTextFieldControl) -> Bool)?) -> FormTextFieldControl {
        shouldEndEditing = handler
        return self
    }
    
    open func shouldChangeCharacters(_ handler: ((FormTextFieldControl, String?, NSRange, String) -> Bool)?) -> FormTextFieldControl {
        shouldChangeCharacters = handler
        return self
    }
    
    open func shouldClear(_ handler: ((FormTextFieldControl) -> Bool)?) -> FormTextFieldControl {
        shouldClear = handler
        return self
    }
    
    open func shouldReturn(_ handler: ((FormTextFieldControl) -> Bool)?) -> FormTextFieldControl {
        shouldReturn = handler
        return self
    }
    
}

// MARK: - UITextFieldDelegate

extension FormTextFieldControl: UITextFieldDelegate {
    
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
