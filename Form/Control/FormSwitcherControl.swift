//
//  FormSwitchStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormSwitcherControl: UISwitch, FormControllable {

    var isMain: Bool
    let name: String
    var layoutDelegate: FormStackControlElementLayoutDelegate?
    
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
    
    func layoutDelegate(_ layoutDelegate: FormStackControlElementLayoutDelegate?) {
        self.layoutDelegate = layoutDelegate
    }
    
    // MARK: - Actions
    
    @objc private func onChangeEvent(_ sender: Any) {
        onChange?(self, isOn)
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
    
}
