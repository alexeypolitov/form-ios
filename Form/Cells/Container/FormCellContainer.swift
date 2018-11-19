//
//  FormCellContainer.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

class FormCellContainer: FormCell, FormCellSelectable {

    override var viewClass: FormCellView.Type { return FormCellContainerView.self }
    var element: FormControllable?    
    var insets: UIEdgeInsets = UIEdgeInsets.zero
    var minimalInset: CGFloat = 8
    
    override init(_ name: String = UUID().uuidString) {
        super.init(name)
        
        self.insets = FormHeaderFooterContainer.appearance.insets
    }
    
    override func onPrepare(_ view: FormCellView) {
        guard let `view` = view as? FormCellContainerView else { return }
        
        view.dataSource = self
    }
    
    class Appearance {
        var insets: UIEdgeInsets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
    }
    
    static let appearance = Appearance()
    
    // MARK: - FormCellSelectable
    var onSelect: ((FormCellContainer) -> Void)?
    
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
    
    func formCellOnSelect() {
        onSelect?(self)
    }
    
}

extension FormCellContainer: FormCellContainerViewDataSource {
    
    func formCellContainerViewElement(_ view: FormCellContainerView) -> FormControllable? {
        return element
    }
    
    func formCellContainerViewInsets(_ view: FormCellContainerView) -> UIEdgeInsets? {
        return insets
    }
    
}

// MARK: - FormLayoutable

extension FormCellContainer: FormLayoutable {
    
    func updateControlLayout(element: FormControllable) {
        updateFormView()
    }
    
}

// MARK: - FormSearchable

extension FormCellContainer: FormSearchable {
    
    func control(_ name: String) -> FormControllable? {
        if element?.name == name {
            return element
        }
        if let `element` = element as? FormSearchable {
            return element.control(name)
        }
        return nil
    }
    
}

// MARK: - FormValidatable

extension FormCellContainer: FormValidatable {
    
    func validate() -> (Bool, String?) {
        
        if let `element` = element as? FormValidatable {
            return element.validate()
        }
        
        return (true, nil)
    }
    
}

// MARK: - Setters

extension FormCellContainer {
    
    func element(_ element: FormControllable?) -> FormCellContainer {
        self.element = element
        self.element?.layoutDelegate = self
        return self
    }
    
    func insets(_ insets: UIEdgeInsets) -> FormCellContainer {
        self.insets = insets
        return self
    }
    
    func onSelect(_ handler: ((FormCellContainer) -> Void)?) -> FormCellContainer {
        onSelect = handler
        return self
    }
}
