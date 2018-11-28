//
//  FormViewKeyboard.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/24.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

public protocol FormViewInputable {
    var inputSource: FormViewInputSource? { get set }
}

open class FormViewInputSource {
    open var inputView: UIView?
    open var inputAccessoryView: UIView?
    open var keyboardType:UIKeyboardType?
    open var returnKeyType:UIReturnKeyType?
    
    public init() { }
}
