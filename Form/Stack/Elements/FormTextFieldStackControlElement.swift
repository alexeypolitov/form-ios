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
    var stackDelegate: FormStackControlElementDelegate?
    var layoutDelegate: FormStackControlElementLayoutDelegate?
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init(name: String = UUID().uuidString,
         _ text: String? = nil,
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
        
    }
    
    func prepareStackDelegate(delegate: FormStackControlElementDelegate) {
        stackDelegate = delegate
    }
    
}

// MARK: - Setters

extension FormTextFieldStackControlElement {

    func textAlignment(_ textAlignment: NSTextAlignment) -> FormTextFieldStackControlElement {
        self.textAlignment = textAlignment
        return self
    }
    
    func text(_ text: String?) -> FormTextFieldStackControlElement {
        self.text = text
        return self
    }
    
    func attributedText(_ text: NSAttributedString?) -> FormTextFieldStackControlElement {
        self.attributedText = text
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
    
}
