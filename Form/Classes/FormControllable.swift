//
//  FormStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

// MARK: - Layoutable

public protocol FormLayoutable {
    func updateControlLayout(element: FormControllable)
}

// MARK: - Sizeable

public protocol FormSizeable {
    var fixedWidth: CGFloat? { get set }
    var fixedHeigth: CGFloat? { get set }
}

// MARK: - Searchable

public protocol FormSearchable {
    func control(_ name: String) -> FormControllable?
    func bindableControls(_ bindName: String) -> [FormBindable]
}

// MARK: - Selectable

public protocol FormSelectable {
    var selectionStyle: UITableViewCell.SelectionStyle? { get set }
    var accessoryType: UITableViewCell.AccessoryType? { get set }
    var onSelect: ((FormCellContainer) -> Void)? { get set }
}

// MARK: - Binding

public protocol FormBindable {
    var bindDelegate: FormViewBindDelegate? { get set }
    var bindName: String? { get set }
    func bindDelegate(_ bindDelegate: FormViewBindDelegate?)
    func refreshBindValue()
}

public protocol FormViewBindDelegate {
    func bindValueChanged(control: FormControllable, bindName: String, value: Any?)
    func bindValue(_ bindName: String) -> Any?
}

// MARK: - OnLoad

public protocol FormOnLoad {
    var onLoad: ((FormControllable) -> Void)? { get set }
    func prepareOnLoad() -> Void
}

extension FormOnLoad {
    public func prepareOnLoad() -> Void {  }
}

// MARK: - Subscontrols
public protocol FormContainerable {
    func controlsNames() -> [String]
}

extension FormContainerable {
    public func controlsNames() -> [String] {
        return []
    }
}

// MARK: - Controllable

public protocol FormControllable {
    var isMain: Bool { get set }
    var name: String { get }

    var layoutDelegate: FormLayoutable? { get set }
    func layoutDelegate(_ layoutDelegate: FormLayoutable?)
}

