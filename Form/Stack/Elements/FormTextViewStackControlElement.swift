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
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init(name: String = UUID().uuidString,
         _ text: String? = nil,
         placeholder: String? = nil,
         isMultiline: Bool = false,
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
