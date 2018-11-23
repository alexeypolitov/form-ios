//
//  FormStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

// MARK: - Layoutable

public protocol FormViewLayoutable {
    func updateControlLayout(element: FormViewControllable)
}

// MARK: - Sizeable

public protocol FormViewSizeable {
    var fixedWidth: CGFloat? { get set }
    var fixedHeigth: CGFloat? { get set }
}

// MARK: - Searchable

public protocol FormViewSearchable {
    func control(_ name: String) -> FormViewControllable?
    func bindableControls(_ bindName: String) -> [FormViewBindable]
}

// MARK: - Selectable

public protocol FormViewSelectable {
    var selectionStyle: UITableViewCell.SelectionStyle? { get set }
    var accessoryType: UITableViewCell.AccessoryType? { get set }
    var onSelect: ((FormViewCellContainer) -> Void)? { get set }
}

// MARK: - Binding

public protocol FormViewBindable {
    var bindDelegate: FormViewBindDelegate? { get set }
    var bindName: String? { get set }
    func bindDelegate(_ bindDelegate: FormViewBindDelegate?)
    func refreshBindValue()
}

public protocol FormViewBindDelegate {
    func bindValueChanged(control: FormViewControllable, bindName: String, value: Any?)
    func bindValue(_ bindName: String) -> Any?
}

// MARK: - OnLoad

public protocol FormViewOnLoad {
    var onLoad: ((FormViewControllable) -> Void)? { get set }
    func prepareOnLoad() -> Void
}

extension FormViewOnLoad {
    public func prepareOnLoad() -> Void {  }
}

// MARK: - Subscontrols
public protocol FormViewContainerable {
    func controlsNames() -> [String]
}

extension FormViewContainerable {
    public func controlsNames() -> [String] {
        return []
    }
}

// MARK: - Controllable

public protocol FormViewControllable {
    var isMain: Bool { get set }
    var name: String { get }

    var layoutDelegate: FormViewLayoutable? { get set }
    func layoutDelegate(_ layoutDelegate: FormViewLayoutable?)
}

