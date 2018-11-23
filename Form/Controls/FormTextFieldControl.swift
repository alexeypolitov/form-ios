//
//  FormTextFieldStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormTextFieldControl: UITextField, FormControllable, FormValuable, FormValidatable, FormBindable, FormOnLoad {
    
    var isMain: Bool
    let name: String
    var layoutDelegate: FormLayoutable?
    
    open override var text: String? {
        didSet {
            _value = text
//            _pandingValue = nil
        }
    }
    
    var onChange: ((FormTextFieldControl, String?) -> Void)?
    var onBeginEditing: ((FormTextFieldControl) -> Void)?
    var onEndEditing: ((FormTextFieldControl, UITextField.DidEndEditingReason) -> Void)?
    var shouldBeginEditing: ((FormTextFieldControl) -> Bool)?
    var shouldEndEditing: ((FormTextFieldControl) -> Bool)?
    var shouldClear: ((FormTextFieldControl) -> Bool)?
    var shouldReturn: ((FormTextFieldControl) -> Bool)?
    var shouldChangeCharacters: ((FormTextFieldControl, String?, NSRange, String) -> Bool)?
    
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
    
    func layoutDelegate(_ layoutDelegate: FormLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
    // MARK: - FormValuable
    
    private var _value: Any?
    var value: Any? {
        get {
            return _value
        }
        set {
            if let `stringValue` = newValue as? String {
                let _ = text(stringValue)
                _value = newValue
            } else {
                let _ = text(nil)
                _value = nil
            }
        }
    }
//    private var _pandingValue: Any?
//    var pandingValue: Any? {
//        get {
//            return _pandingValue
//        }
//        set {
//            _pandingValue = newValue
//        }
//    }
    
    // MARK: - FormValidatable
    
    var validators: [FormValidator] = []
    
    func validate() -> (Bool, String?) {
        
        if validators.count  == 0 { return (true, nil) }
        
        if let message = prepareValidateByPriority(priority: .high, validators) {
            return (false, message)
        }
        
        if let message = prepareValidateByPriority(priority: .medium, validators) {
            return (false, message)
        }
        
        if let message = prepareValidateByPriority(priority: .low, validators) {
            return (false, message)
        }
        
        return (true, nil)
    }

    private func prepareValidateByPriority(priority: FormValidator.Priority,_ validators: [FormValidator]) -> String? {
        let localValidators = validators.filter { (validator) -> Bool in
            return validator.priority == priority
        }
        
        for validator in localValidators {
            if !validator.validate(self) {
                return validator.message
            }
        }
        
        return nil
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

extension FormTextFieldControl {
    
    func isMain(_ isMain: Bool) -> FormTextFieldControl {
        self.isMain = isMain
        return self
    }
    
    func textAlignment(_ textAlignment: NSTextAlignment) -> FormTextFieldControl {
        self.textAlignment = textAlignment
        return self
    }
    
    func text(_ text: String?) -> FormTextFieldControl {
        self.text = text
        return self
    }
    
    func font(_ font: UIFont) -> FormTextFieldControl {
        self.font = font
        return self
    }
    
    func placeholder(_ placeholder: String) -> FormTextFieldControl {
        self.placeholder = placeholder
        return self
    }
    
    func backgroundColor(_ backgroundColor: UIColor?) -> FormTextFieldControl {
        self.backgroundColor = backgroundColor
        return self
    }
    
    func onChange(_ handler: ((FormTextFieldControl, String?) -> Void)?) -> FormTextFieldControl {
        onChange = handler
        return self
    }
    
    func bind(_ bindName: String?) -> FormTextFieldControl {
        self.bindName = bindName
        return self
    }
    
    func onLoad(_ handler: ((FormControllable) -> Void)?) -> FormTextFieldControl {
        self.onLoad = handler
        return self
    }
    
    func onBeginEditing(_ handler: ((FormTextFieldControl) -> Void)?) -> FormTextFieldControl {
        onBeginEditing = handler
        return self
    }
    
    func onEndEditing(_ handler: ((FormTextFieldControl, UITextField.DidEndEditingReason) -> Void)?) -> FormTextFieldControl {
        onEndEditing = handler
        return self
    }
    
    func shouldBeginEditing(_ handler: ((FormTextFieldControl) -> Bool)?) -> FormTextFieldControl {
        shouldBeginEditing = handler
        return self
    }
    
    func shouldEndEditing(_ handler: ((FormTextFieldControl) -> Bool)?) -> FormTextFieldControl {
        shouldEndEditing = handler
        return self
    }
    
    func shouldChangeCharacters(_ handler: ((FormTextFieldControl, String?, NSRange, String) -> Bool)?) -> FormTextFieldControl {
        shouldChangeCharacters = handler
        return self
    }
    
    func shouldClear(_ handler: ((FormTextFieldControl) -> Bool)?) -> FormTextFieldControl {
        shouldClear = handler
        return self
    }
    
    func shouldReturn(_ handler: ((FormTextFieldControl) -> Bool)?) -> FormTextFieldControl {
        shouldReturn = handler
        return self
    }
    
    func validators(_ validators: [FormValidator]) -> FormTextFieldControl {
        self.validators = validators
        return self
    }
    
    func validator(_ validator: FormValidator) -> FormTextFieldControl {
        self.validators = [validator]
        return self
    }
    
}

// MARK: - UITextFieldDelegate

extension FormTextFieldControl: UITextFieldDelegate {
    
    @objc open func onTextDidChange(notification: Notification) {
        value = text
        
        onChange?(self, text)
        
        if let `bindName` = bindName {
            bindDelegate?.bindValueChanged(control: self, bindName: bindName, value: _value)
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
//        if let text = textField.text {
//            _pandingValue = (text as NSString).replacingCharacters(in: range, with: text)
//        } else {
//            _pandingValue = nil
//        }
//
//        // Inline validation
//        let (success, _ ) = validateInline()
//        if !success {
//            _pandingValue = nil
//            return false
//        }
//
//        // Other validation
//        let result = shouldChangeCharacters?(self, textField.text, range, string) ?? true
//        _pandingValue = nil
//        if result, let text = textField.text {
//            _value = (text as NSString).replacingCharacters(in: range, with: string)
//        } else {
//            _value = textField.text
//        }
//
//        if let `bindName` = bindName {
//            bindDelegate?.bindValueChanged(control: self, bindName: bindName, value: _value)
//        }
//
//        return result
    }
    
}
