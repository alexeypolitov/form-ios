//
//  FormStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

protocol FormLayoutable {
    func updateControlLayout(element: FormControllable)
}

protocol FormSizeable {
    var fixedWidth: CGFloat? { get set }
    var fixedHeigth: CGFloat? { get set }
}

protocol FormSearchable {
    func control(_ name: String) -> FormControllable?
}

protocol FormValuable {
    var value: Any? { get set }
    var pandingValue: Any? { get set }
}

protocol FormValidatable {
//    var validators: [FormValidator]? { get set }
    func validate() -> (Bool, String?)
}

protocol FormControllable {
    var isMain: Bool { get set }
    var name: String { get }

    var layoutDelegate: FormLayoutable? { get set }
    func layoutDelegate(_ layoutDelegate: FormLayoutable?)
}

