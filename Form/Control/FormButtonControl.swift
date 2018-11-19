//
//  FormButtonControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/19.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormButtonControl: ExtendedButton, FormControllable, FormSizeable {
    
    var isMain: Bool
    let name: String
    var layoutDelegate: FormStackControlElementLayoutDelegate?
    
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
    }
    
    func layoutDelegate(_ layoutDelegate: FormStackControlElementLayoutDelegate?) {
        self.layoutDelegate = layoutDelegate
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
    
    func fixedWidth(_ width: CGFloat?) -> FormButtonControl {
        self.fixedWidth = width
        return self
    }
    
    func fixedHeigth(_ height: CGFloat?) -> FormButtonControl {
        self.fixedHeigth = height
        return self
    }

}

