//
//  FormSwitchStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewSwitcher: UISwitch, FormControllable, FormBindable, FormOnLoad {

    public var isMain: Bool
    public let name: String
    public var layoutDelegate: FormLayoutable?
    
    open var onChange: ((FormViewSwitcher, Bool) -> Void)?
    
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
    
    open func layoutDelegate(_ layoutDelegate: FormLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
    // MARK: - Actions
    
    @objc private func onChangeEvent(_ sender: Any) {
        onChange?(self, isOn)
        
        if let `bindName` = bindName {
            bindDelegate?.bindValueChanged(control: self, bindName: bindName, value: isOn)
        }
    }
    
    // MARK: - FormBindable
    
    open var bindDelegate: FormViewBindDelegate?
    open var bindName: String?
    
    open func bindDelegate(_ bindDelegate: FormViewBindDelegate?) {
        self.bindDelegate = bindDelegate
    }
    
    open func refreshBindValue() {
        guard let `bindDelegate` = bindDelegate, let `bindName` = bindName else { return }
        guard let bindValue = bindDelegate.bindValue(bindName) as? Bool else { return }
        
        let _ = isOn(bindValue)
    }
    
    // MARK: - FormOnLoad
    open var onLoad: ((FormControllable) -> Void)?
}

// MARK: - Setters

extension FormViewSwitcher {

    open func isMain(_ isMain: Bool) -> FormViewSwitcher {
        self.isMain = isMain
        return self
    }
    
    open func isOn(_ isOn: Bool) -> FormViewSwitcher {
        self.isOn = isOn
        return self
    }
    
    open func onChange(_ handler: ((FormViewSwitcher, Bool) -> Void)?) -> FormViewSwitcher {
        onChange = handler
        return self
    }
    
    open func backgroundColor(_ backgroundColor: UIColor?) -> FormViewSwitcher {
        self.backgroundColor = backgroundColor
        return self
    }
    
    open func bind(_ bindName: String?) -> FormViewSwitcher {
        self.bindName = bindName
        return self
    }
    
    open func onLoad(_ handler: ((FormControllable) -> Void)?) -> FormViewSwitcher {
        self.onLoad = handler
        return self
    }
}
