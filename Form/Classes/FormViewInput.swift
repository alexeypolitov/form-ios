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
    var inputView: UIView?
    var inputAccessoryView: UIView?
    var keyboardType:UIKeyboardType?
    var returnKeyType:UIReturnKeyType? 
}
