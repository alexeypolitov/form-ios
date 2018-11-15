//
//  FormSwitchLabelControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

class FormSwitchLabelControl: FormLabelControl {

    lazy var formSwitch: FormSwitchStackControlElement = {
        let switchControl = FormSwitchStackControlElement(isMain: false)
        switchControl.addTarget(self, action: #selector(self.onChange(_:)), for: .valueChanged)
        return switchControl
    }()
    
    init(name: String = UUID().uuidString, text: String? = nil, isOn: Bool = false) {
        super.init(name: name)
        
        formTextLabel.text = text
        formSwitch.isOn = isOn
    }
    
    // MARK: - Layout
    
    override func prepareElements() {        
        super.prepareElements()
        
        if elements.firstIndex(where: {$0.name == formSwitch.name}) == nil {
            elements.append(formSwitch)
        }
    }
    
    // MARK: - Action
    var onChangeHandler: ((FormSwitchLabelControl, Bool) -> Void)?
    
    @objc private func onChange(_ sender: Any) {
        onChangeHandler?(self, formSwitch.isOn)
    }
}
