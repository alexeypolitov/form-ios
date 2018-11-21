//
//  FormSwitchStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormSwitcherControl: UISwitch, FormControllable, FormBindable {

    var isMain: Bool
    let name: String
    var layoutDelegate: FormLayoutable?
    
    var onChange: ((FormSwitcherControl, Bool) -> Void)?
    
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
    
    func layoutDelegate(_ layoutDelegate: FormLayoutable?) {
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
    
    var bindDelegate: FormViewBindDelegate?
    var bindName: String?
    
    func bindDelegate(_ bindDelegate: FormViewBindDelegate?) {
        self.bindDelegate = bindDelegate
    }
    
    func refreshBindValue() {
        guard let `bindDelegate` = bindDelegate, let `bindName` = bindName else { return }
        guard let bindValue = bindDelegate.bindValue(bindName) as? Bool else { return }
        
        let _ = isOn(bindValue)
    }
}

// MARK: - Setters

extension FormSwitcherControl {

    func isMain(_ isMain: Bool) -> FormSwitcherControl {
        self.isMain = isMain
        return self
    }
    
    func isOn(_ isOn: Bool) -> FormSwitcherControl {
        self.isOn = isOn
        return self
    }
    
    func onChange(_ handler: ((FormSwitcherControl, Bool) -> Void)?) -> FormSwitcherControl {
        onChange = handler
        return self
    }
    
    func backgroundColor(_ backgroundColor: UIColor?) -> FormSwitcherControl {
        self.backgroundColor = backgroundColor
        return self
    }
    
    func bind(_ bindName: String?) -> FormSwitcherControl {
        self.bindName = bindName
        return self
    }
}
