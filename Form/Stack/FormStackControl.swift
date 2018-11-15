//
//  FormBadgeLabelControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/18.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormStackControl: FormControl, FormControlSelectable {
    
    var insets: UIEdgeInsets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
    var minimalInset: CGFloat = 8
    
    var elements: [FormStackControlElement] = []
    var onSelect: ((FormStackControl) -> Void)?
    
    init(_ name: String = UUID().uuidString, elements: [FormStackControlElement] = []) {
        super.init(name: name)
        
        precondition(elements.filter({$0.isMain}).count <= 1, "Only one element could be main")
        
        elements.forEach({$0.prepareStackDelegate(delegate: self)})
        self.elements = elements
    }

    // MARK: - Cell
    
    open override var cellClass: UITableViewCell.Type {
        return FormStackControlCell.self
    }
    
    // MARK: - Preparation
    
    open override func prepare(cell: UITableViewCell) {
        super.prepare(cell: cell)
        
        guard let `cell` = cell as? FormStackControlCell else {
            return
        }
        
        cell.dataSource = self
        
    }
    
    // MARK: - Accessories
    
    func element(by name: String) -> FormStackControlElement? {
        return elements.first(where: {$0.name == name})
    }
    
    // MARK: - Elements
    
    func prepareElements() {
        // to add custom elements
    }
    
    // MARK: - FormControlSelectable
    
    private var _selectionStyle: UITableViewCell.SelectionStyle = .default
    var selectionStyle: UITableViewCell.SelectionStyle {
        get {
            if onSelect == nil {
                return .none
            } else {
                return _selectionStyle
            }
        }
        set {
            _selectionStyle = newValue
        }
    }
    private var _accessoryType: UITableViewCell.AccessoryType = .none
    var accessoryType: UITableViewCell.AccessoryType {
        get {
            return _accessoryType
        }
        set {
            _accessoryType = newValue
        }
    }
        
    func formControlOnSelect() {        
        onSelect?(self)
    }
}

// MARK: - FormStackControlCellDataSource

extension FormStackControl: FormStackControlCellDataSource {
    
    func numberOfElements() -> Int {
        return elements.count
    }
    
    func element(at index: Int) -> FormStackControlElement {
        return elements[index]
    }
    
    func elementsInsets() -> UIEdgeInsets {
        return insets
    }
    
    func minimalInsetBetweenElements() -> CGFloat {
        return minimalInset
    }
    
}

// MARK: - FormStackControlElementDelegate

extension FormStackControl: FormStackControlElementDelegate {
    
    func updateControl() {
        guard let formView = linkedCell?.superview?.superview as? FormView else { return }
        formView.updateControls()
    }
    
    func buildLayout() {
        guard let `linkedCell` = linkedCell as? FormStackControlCell else { return }
        linkedCell.buildLayout()
        
        updateControl()
    }
    
}

// MARK: - FormStackControlElementLayoutDelegate

extension FormStackControl: FormStackControlElementLayoutDelegate {
    
    func updateControlLayout(element: FormStackControlElement) {
        prepareElements()
        buildLayout()
    }
    
}

// MARK: - Setters

extension FormStackControl {
    
    func add(_ element: FormStackControlElement) -> FormStackControl {
        element.prepareStackDelegate(delegate: self)
        elements.append(element)
        return self
    }
    
    func onSelect(_ handler: ((FormStackControl) -> Void)?) -> FormStackControl {
        onSelect = handler
        return self
    }
    
    func onInsets(_ insets: UIEdgeInsets) -> FormStackControl {
        self.insets = insets
        return self
    }
    
    func onMinimalInset(_ minimalInset: CGFloat) -> FormStackControl {
        self.minimalInset = minimalInset
        return self
    }
    
}
