//
//  FormImageStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

class FormImageStackControlElement: UIImageView, FormStackControlElement, FormStackControlElementSizing {

    var isMain: Bool
    let name: String
    var stackDelegate: FormStackControlElementDelegate?
    var layoutDelegate: FormStackControlElementLayoutDelegate?
    
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
    
    func prepareStackDelegate(delegate: FormStackControlElementDelegate) {
        stackDelegate = delegate
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

extension FormImageStackControlElement {
    
    func isMain(_ isMain: Bool) -> FormImageStackControlElement {
        self.isMain = isMain
        return self
    }
    
    func image(_ image: UIImage?) -> FormImageStackControlElement {
        self.image = image
        return self
    }
    
    func fixedWidth(_ width: CGFloat?) -> FormImageStackControlElement {
        self.fixedWidth = width
        return self
    }
    
    func fixedHeigth(_ height: CGFloat?) -> FormImageStackControlElement {
        self.fixedHeigth = height
        return self
    }
    
}
