//
//  FormStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

// MARK: - Layoutable

protocol FormLayoutable {
    func updateControlLayout(element: FormControllable)
}

// MARK: - Sizeable

protocol FormSizeable {
    var fixedWidth: CGFloat? { get set }
    var fixedHeigth: CGFloat? { get set }
}

// MARK: - Searchable

protocol FormSearchable {
    func control(_ name: String) -> FormControllable?
    func bindableControls(_ bindName: String) -> [FormBindable]
}

// MARK: - Valuable

protocol FormValuable {
    var value: Any? { get set }
    var pandingValue: Any? { get set }
}

// MARK: - Validatable

protocol FormValidatable {
    func validate() -> (Bool, String?)
}

// MARK: - Selectable

protocol FormSelectable {
    var selectionStyle: UITableViewCell.SelectionStyle? { get set }
    var accessoryType: UITableViewCell.AccessoryType? { get set }
    var onSelect: ((FormCellContainer) -> Void)? { get set }
}

// MARK: - Binding

protocol FormBindable {
    var bindDelegate: FormViewBindDelegate? { get set }
    var bindName: String? { get set }
    func bindDelegate(_ bindDelegate: FormViewBindDelegate?)
    func refreshBindValue()
}

protocol FormViewBindDelegate {
    func bindValueChanged(control: FormControllable, bindName: String, value: Any?)
    func bindValue(_ bindName: String) -> Any?
}

// MARK: - OnLoad

protocol FormOnLoad {
    var onLoad: ((FormControllable) -> Void)? { get set }
    func prepareOnLoad() -> Void
}

extension FormOnLoad {
    func prepareOnLoad() -> Void {  }
}

// MARK: - Subscontrols
protocol FormContainerable {
    func controlsNames() -> [String]
}

extension FormContainerable {
    func controlsNames() -> [String] {
        return []
    }
}

// MARK: - Controllable

protocol FormControllable {
    var isMain: Bool { get set }
    var name: String { get }

    var layoutDelegate: FormLayoutable? { get set }
    func layoutDelegate(_ layoutDelegate: FormLayoutable?)
}

