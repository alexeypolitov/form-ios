//
//  FormImageStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

class FormImageControl: UIImageView, FormControllable, FormSizeable, FormBindable {

    var isMain: Bool
    let name: String
    var layoutDelegate: FormLayoutable?
    
    open override var image: UIImage? {
        didSet {
            layoutDelegate?.updateControlLayout(element: self)
        }
    }
    
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
    
    func layoutDelegate(_ layoutDelegate: FormLayoutable?) {
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
    
    // MARK: - FormBindable
    
    var bindDelegate: FormViewBindDelegate?
    var bindName: String?
    
    func bindDelegate(_ bindDelegate: FormViewBindDelegate?) {
        self.bindDelegate = bindDelegate
    }
    
    func refreshBindValue() {
        guard let `bindDelegate` = bindDelegate, let `bindName` = bindName else { return }
        guard let bindValue = bindDelegate.bindValue(bindName) as? UIImage else { return }
        
        let _ = image(bindValue)
    }
}


// MARK: - Setters

extension FormImageControl {
    
    func isMain(_ isMain: Bool) -> FormImageControl {
        self.isMain = isMain
        return self
    }
    
    func image(_ image: UIImage?) -> FormImageControl {
        self.image = image
        return self
    }
    
    func fixedWidth(_ width: CGFloat?) -> FormImageControl {
        self.fixedWidth = width
        return self
    }
    
    func fixedHeigth(_ height: CGFloat?) -> FormImageControl {
        self.fixedHeigth = height
        return self
    }
    
    func backgroundColor(_ backgroundColor: UIColor?) -> FormImageControl {
        self.backgroundColor = backgroundColor
        return self
    }
    
    func bind(_ bindName: String?) -> FormImageControl {
        self.bindName = bindName
        return self
    }
    
}
