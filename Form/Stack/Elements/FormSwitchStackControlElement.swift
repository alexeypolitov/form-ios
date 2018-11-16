//
//  FormSwitchStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormSwitchStackControlElement: UISwitch, FormStackControlElement {

    var isMain: Bool
    let name: String
//    var stackDelegate: FormStackControlElementDelegate?
    var layoutDelegate: FormStackControlElementLayoutDelegate?
    
    var onChange: ((FormSwitchStackControlElement, Bool) -> Void)?
    
    public override init(frame: CGRect) {
        fatalError("Use init()")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init(_ name: String = UUID().uuidString,
         isOn: Bool = true,
         isMain: Bool = false
        )
    {
        self.name = name
        self.isMain = isMain
        
        super.init(frame: CGRect.zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isOn = isOn
        
        self.addTarget(self, action: #selector(self.onChangeEvent(_:)), for: .valueChanged)
    }
    
    func layoutDelegate(_ layoutDelegate: FormStackControlElementLayoutDelegate?) {
        self.layoutDelegate = layoutDelegate
    }
    
//    func prepareStackDelegate(delegate: FormStackControlElementDelegate) {
//        stackDelegate = delegate
//    }
        
    // MARK: - Actions
    @objc private func onChangeEvent(_ sender: Any) {
        onChange?(self, isOn)
    }
}

// MARK: - Setters

extension FormSwitchStackControlElement {

    func isMain(_ isMain: Bool) -> FormSwitchStackControlElement {
        self.isMain = isMain
        return self
    }
    
    func isOn(_ isOn: Bool) -> FormSwitchStackControlElement {
        self.isOn = isOn
        return self
    }
    
    func onChange(_ handler: ((FormSwitchStackControlElement, Bool) -> Void)?) -> FormSwitchStackControlElement {
        onChange = handler
        return self
    }
    
    func backgroundColor(_ backgroundColor: UIColor?) -> FormSwitchStackControlElement {
        self.backgroundColor = backgroundColor
        return self
    }
    
}
