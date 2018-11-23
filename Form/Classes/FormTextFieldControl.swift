//
//  FormTextFieldStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormTextFieldControl: UITextField, FormControllable, FormBindable, FormOnLoad {
    
    var isMain: Bool
    let name: String
    var layoutDelegate: FormLayoutable?
    
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
