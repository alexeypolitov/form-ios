//
//  FormButtonControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewButton: ExtendedButton, FormViewControllable, FormViewSizeable, FormViewOnLoad {
    
    public var isMain: Bool
    public let name: String
    public var layoutDelegate: FormViewLayoutable?
    
    open var onAction: ((FormViewButton) -> Void)?
    
    public override init(frame: CGRect) {
        fatalError("Use init()")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    public init(_ name: String = UUID().uuidString,
         isMain: Bool = false
        )
    {
        self.name = name
        self.isMain = isMain
        
        super.init(frame: CGRect.zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitleColor(UIColor.black, for: .normal)
        self.addTarget(self, action: #selector(self.onActionEvent(_:)), for: .touchUpInside)
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
    
    // MARK: - FormViewOnLoad
    open var onLoad: ((Any) -> Void)?
}

// MARK: - Setters

extension FormViewButton {
    
    open func isMain(_ isMain: Bool) -> FormViewButton {
        self.isMain = isMain
        return self
    }
    
    open func title(_ title: String?, for state: UIControl.State) -> FormViewButton {
        self.setTitle(title, for: state)
        return self
    }
    
    open func titleColor(_ titleColor: UIColor?, for state: UIControl.State) -> FormViewButton {
        self.setTitleColor(titleColor, for: state)
        return self
    }
        
    open func attributedTitle(_ attributedTitle: NSAttributedString?, for state: UIControl.State) -> FormViewButton {
        self.setAttributedTitle(attributedTitle, for: state)
        return self
    }
    
    open func backgroundColor(_ backgroundColor: UIColor?, for state: UIControl.State) -> FormViewButton {
        self.setBackgroundColor(backgroundColor, for: state)
        return self
    }
    
    open func cornerRadius(_ cornerRadius: CGFloat?, for state: UIControl.State) -> FormViewButton {
        self.setCornerRadius(cornerRadius, for: state)
        return self
    }
    
    open func borderWidth(_ borderWidth: CGFloat?, for state: UIControl.State) -> FormViewButton {
        self.setBorderWidth(borderWidth, for: state)
        return self
    }
    
    open func borderColor(_ borderColor: UIColor?, for state: UIControl.State) -> FormViewButton {
        self.setBorderColor(borderColor, for: state)
        return self
    }

    open func isEnabled(_ isEnabled: Bool) -> FormViewButton {
        self.isEnabled = isEnabled
        return self
    }
    
    open func onAction(_ handler: ((FormViewButton) -> Void)?) -> FormViewButton {
        onAction = handler
        return self
    }
    
    open func fixedWidth(_ width: CGFloat?) -> FormViewButton {
        self.fixedWidth = width
        return self
    }
    
    open func fixedHeigth(_ height: CGFloat?) -> FormViewButton {
        self.fixedHeigth = height
        return self
    }

    open func onLoad(_ handler: ((Any) -> Void)?) -> FormViewButton {
        self.onLoad = handler
        return self
    }
}

