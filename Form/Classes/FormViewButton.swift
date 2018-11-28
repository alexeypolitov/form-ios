//
//  FormButtonControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewButton: ExtendedButton, FormViewControllable, FormViewSizeable, FormViewOnLoad {
    
    public var isMain: Bool = false
    public let name: String
    public var layoutDelegate: FormViewLayoutable?
    
    open var onAction: ((FormViewButton) -> Void)?
    
    public override init(frame: CGRect) {
        fatalError("Use init()")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    public init(_ name: String = UUID().uuidString, _ initializer: @escaping (FormViewButton) -> Void = { _ in }) {
        self.name = name
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitleColor(UIColor.black, for: .normal)
        self.addTarget(self, action: #selector(self.onActionEvent(_:)), for: .touchUpInside)
        initializer(self)
    }
    
    open func layoutDelegate(_ layoutDelegate: FormViewLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
    // MARK: - Actions
    
    @objc private func onActionEvent(_ sender: Any) {
        onAction?(self)
    }
    
    // MARK: - FormStackControlElementSizing
    
    private var _fixedWidth:CGFloat?
    open var fixedWidth: CGFloat? {
        get {
            return _fixedWidth
        }
        set {
            _fixedWidth = newValue
        }
    }
    private var _fixedHeigth:CGFloat?
    open var fixedHeigth: CGFloat? {
        get {
            return _fixedHeigth
        }
        set {
            _fixedHeigth = newValue
        }
    }
    private var _minimumHeight:CGFloat?
    open var minimumHeight: CGFloat? {
        get {
            return _minimumHeight
        }
        set {
            _minimumHeight = newValue
        }
    }
    private var _minimumWidth:CGFloat?
    open var minimumWidth: CGFloat? {
        get {
            return _minimumWidth
        }
        set {
            _minimumWidth = newValue
        }
    }
    
    // MARK: - FormViewOnLoad
    open var onLoad: ((Any) -> Void)?
}

