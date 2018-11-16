//
//  FormTextFieldStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormTextFieldStackControlElement: UITextField, FormStackControlElement { //, UITextFieldDelegate {
    
    var isMain: Bool
    let name: String
//    var stackDelegate: FormStackControlElementDelegate?
    var layoutDelegate: FormStackControlElementLayoutDelegate?
    
    var onChange: ((FormTextFieldStackControlElement, String?) -> Void)?
    var onBeginEditing: ((FormTextFieldStackControlElement) -> Void)?
    var onEndEditing: ((FormTextFieldStackControlElement, UITextField.DidEndEditingReason) -> Void)?
    var shouldBeginEditing: ((FormTextFieldStackControlElement) -> Bool)?
    var shouldEndEditing: ((FormTextFieldStackControlElement) -> Bool)?
    var shouldClear: ((FormTextFieldStackControlElement) -> Bool)?
    var shouldReturn: ((FormTextFieldStackControlElement) -> Bool)?
    var shouldChangeCharacters: ((FormTextFieldStackControlElement, String?, NSRange, String) -> Bool)?
    
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
        self.delegate = self
        
    }
    
    func layoutDelegate(_ layoutDelegate: FormStackControlElementLayoutDelegate?) {
        self.layoutDelegate = layoutDelegate
    }
//    func prepareStackDelegate(delegate: FormStackControlElementDelegate) {
//        stackDelegate = delegate
//    }
    
}

// MARK: - Setters

extension FormTextFieldStackControlElement {
    
    func isMain(_ isMain: Bool) -> FormTextFieldStackControlElement {
        self.isMain = isMain
        return self
    }
    
    func textAlignment(_ textAlignment: NSTextAlignment) -> FormTextFieldStackControlElement {
        self.textAlignment = textAlignment
        return self
    }
    
    func text(_ text: String?) -> FormTextFieldStackControlElement {
        self.text = text
        return self
    }
    
    func font(_ font: UIFont) -> FormTextFieldStackControlElement {
        self.font = font
        return self
    }
    
    func placeholder(_ placeholder: String) -> FormTextFieldStackControlElement {
        self.placeholder = placeholder
        return self
    }
    
    func backgroundColor(_ backgroundColor: UIColor?) -> FormTextFieldStackControlElement {
        self.backgroundColor = backgroundColor
        return self
    }
    
    func onChange(_ handler: ((FormTextFieldStackControlElement, String?) -> Void)?) -> FormTextFieldStackControlElement {
        onChange = handler
        return self
    }
    
    func onBeginEditing(_ handler: ((FormTextFieldStackControlElement) -> Void)?) -> FormTextFieldStackControlElement {
        onBeginEditing = handler
        return self
    }
    
    func onEndEditing(_ handler: ((FormTextFieldStackControlElement, UITextField.DidEndEditingReason) -> Void)?) -> FormTextFieldStackControlElement {
        onEndEditing = handler
        return self
    }
    
    func shouldBeginEditing(_ handler: ((FormTextFieldStackControlElement) -> Bool)?) -> FormTextFieldStackControlElement {
        shouldBeginEditing = handler
        return self
    }
    
    func shouldEndEditing(_ handler: ((FormTextFieldStackControlElement) -> Bool)?) -> FormTextFieldStackControlElement {
        shouldEndEditing = handler
        return self
    }
    
    func shouldChangeCharacters(_ handler: ((FormTextFieldStackControlElement, String?, NSRange, String) -> Bool)?) -> FormTextFieldStackControlElement {
        shouldChangeCharacters = handler
        return self
    }
    
    func shouldClear(_ handler: ((FormTextFieldStackControlElement) -> Bool)?) -> FormTextFieldStackControlElement {
        shouldClear = handler
        return self
    }
    
    func shouldReturn(_ handler: ((FormTextFieldStackControlElement) -> Bool)?) -> FormTextFieldStackControlElement {
        shouldReturn = handler
        return self
    }
}

// MARK: - UITextFieldDelegate

extension FormTextFieldStackControlElement: UITextFieldDelegate {
    
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
        let result = shouldChangeCharacters?(self, textField.text, range, string) ?? true
        
        if result, let text = textField.text {
            onChange?(self, (text as NSString).replacingCharacters(in: range, with: string))
        }
        return result
    }
    
}
