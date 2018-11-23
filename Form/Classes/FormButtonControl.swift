//
//  FormButtonControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormButtonControl: ExtendedButton, FormControllable, FormSizeable, FormOnLoad {
    
    var isMain: Bool
    let name: String
    var layoutDelegate: FormLayoutable?
    
     var onAction: ((FormButtonControl) -> Void)?
    
    public override init(frame: CGRect) {
        fatalError("Use init()")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init(_ name: String = UUID().uuidString,
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
    
    func layoutDelegate(_ layoutDelegate: FormLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
    // MARK: - Actions
    
    @objc private func onActionEvent(_ sender: Any) {
        onAction?(self)
    }
    
    // MARK: - FormStackControlElementSizing
    
    private var _fixedWidth:CGFloat?
    var fixedWidth: CGFloat? {
        get {
            return _fixedWidth
        }
        set {
            _fixedWidth = newValue
        }
    }
    private var _fixedHeigth:CGFloat?
    var fixedHeigth: CGFloat? {
        get {
            return _fixedHeigth
        }
        set {
            _fixedHeigth = newValue
        }
    }
    
    // MARK: - FormOnLoad
    var onLoad: ((FormControllable) -> Void)?
}

// MARK: - Setters

extension FormButtonControl {
    
    func isMain(_ isMain: Bool) -> FormButtonControl {
        self.isMain = isMain
        return self
    }
    
    func title(_ title: String?, for state: UIControl.State) -> FormButtonControl {
        self.setTitle(title, for: state)
        return self
    }
    
    func attributedTitle(_ attributedTitle: NSAttributedString?, for state: UIControl.State) -> FormButtonControl {
        self.setAttributedTitle(attributedTitle, for: state)
        return self
    }
    
    func backgroundColor(_ backgroundColor: UIColor?, for state: UIControl.State) -> FormButtonControl {
        self.setBackgroundColor(backgroundColor, for: state)
        return self
    }
    
    func cornerRadius(_ cornerRadius: CGFloat?, for state: UIControl.State) -> FormButtonControl {
        self.setCornerRadius(cornerRadius, for: state)
        return self
    }
    
    func borderWidth(_ borderWidth: CGFloat?, for state: UIControl.State) -> FormButtonControl {
        self.setBorderWidth(borderWidth, for: state)
        return self
    }
    
    func borderColor(_ borderColor: UIColor?, for state: UIControl.State) -> FormButtonControl {
        self.setBorderColor(borderColor, for: state)
        return self
    }

    func isEnabled(_ isEnabled: Bool) -> FormButtonControl {
        self.isEnabled = isEnabled
        return self
    }
    
    func onAction(_ handler: ((FormButtonControl) -> Void)?) -> FormButtonControl {
        onAction = handler
        return self
    }
    
    func fixedWidth(_ width: CGFloat?) -> FormButtonControl {
        self.fixedWidth = width
        return self
    }
    
    func fixedHeigth(_ height: CGFloat?) -> FormButtonControl {
        self.fixedHeigth = height
        return self
    }

    func onLoad(_ handler: ((FormControllable) -> Void)?) -> FormButtonControl {
        self.onLoad = handler
        return self
    }
}

