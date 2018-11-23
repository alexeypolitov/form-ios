//
//  FormImageStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewImageView: UIImageView, FormViewControllable, FormViewSizeable, FormViewBindable, FormViewOnLoad {

    public var isMain: Bool
    public let name: String
    public var layoutDelegate: FormViewLayoutable?
    
    public override init(frame: CGRect) {
        fatalError("Use init()")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init(_ name: String = UUID().uuidString,
         image: UIImage? = nil,
         isMain: Bool = false
        )
    {
        self.isMain = isMain
        self.name = name
        
        super.init(frame: CGRect.zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = image
        self.contentMode = .scaleAspectFit
    }
    
    open func layoutDelegate(_ layoutDelegate: FormViewLayoutable?) {
        self.layoutDelegate = layoutDelegate
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
    
    // MARK: - FormViewBindable
    
    open var bindDelegate: FormViewBindDelegate?
    open var bindName: String?
    
    open func bindDelegate(_ bindDelegate: FormViewBindDelegate?) {
        self.bindDelegate = bindDelegate
    }
    
    open func refreshBindValue() {
        guard let `bindDelegate` = bindDelegate, let `bindName` = bindName else { return }
        guard let bindValue = bindDelegate.bindValue(bindName) as? UIImage else { return }
        
        self.image = bindValue
    }
    
    // MARK: - FormViewOnLoad
    open var onLoad: ((FormViewControllable) -> Void)?
}


// MARK: - Setters

extension FormViewImageView {
    
    open func isMain(_ isMain: Bool) -> FormViewImageView {
        self.isMain = isMain
        return self
    }
    
    open func image(_ image: UIImage?) -> FormViewImageView {
        self.image = image
        layoutDelegate?.updateControlLayout(element: self)
        return self
    }
    
    open func fixedWidth(_ width: CGFloat?) -> FormViewImageView {
        self.fixedWidth = width
        return self
    }
    
    open func fixedHeigth(_ height: CGFloat?) -> FormViewImageView {
        self.fixedHeigth = height
        return self
    }
    
    open func backgroundColor(_ backgroundColor: UIColor?) -> FormViewImageView {
        self.backgroundColor = backgroundColor
        return self
    }
    
    open func bind(_ bindName: String?) -> FormViewImageView {
        self.bindName = bindName
        return self
    }
    
    open func onLoad(_ handler: ((FormViewControllable) -> Void)?) -> FormViewImageView {
        self.onLoad = handler
        return self
    }
    
}
