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
    func validate() -> (Bool, String?)
}

protocol FormSelectable {
    var selectionStyle: UITableViewCell.SelectionStyle? { get set }
    var accessoryType: UITableViewCell.AccessoryType? { get set }
    var onSelect: ((FormCellContainer) -> Void)? { get set }
}

protocol FormBindable {
    var bindDelegate: FormBindDelegate? { get set }
    var bindName: String? { get set }
    func bindDelegate(_ bindDelegate: FormBindDelegate?)
    func refreshBindValue()
}

protocol FormBindDelegate {
    func bindValueChanged(bindName: String, value: Any?)
    func bindValue(_ bindName: String) -> Any?
}

protocol FormControllable {
    var isMain: Bool { get set }
    var name: String { get }

    var layoutDelegate: FormLayoutable? { get set }
    func layoutDelegate(_ layoutDelegate: FormLayoutable?)
}

