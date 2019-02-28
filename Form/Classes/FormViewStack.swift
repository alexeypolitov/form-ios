//
//  FormViewStack.swift
//  Form
//
//  Created by Alexey Politov on 2019/02/28.
//  Copyright © 2019 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewStack: UIStackView, FormViewControllable, FormViewBindable, FormViewOnLoad {
    
    public var isMain: Bool = false
    public let name: String
    public var layoutDelegate: FormViewLayoutable?
    
    public override init(frame: CGRect) {
        fatalError("Use init()")
    }
    
    public required init(coder: NSCoder) {
        fatalError("Use init()")
    }
    
    public init(_ name: String = UUID().uuidString, _ initializer: @escaping (FormViewStack) -> Void = { _ in }) {
        self.name = name
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        initializer(self)
    }
    
    open func layoutDelegate(_ layoutDelegate: FormViewLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
    // MARK: - FormViewBindable
    
    open var bindDelegate: FormViewBindDelegate?
    open var bindName: String?
    
    open func bindDelegate(_ bindDelegate: FormViewBindDelegate?) {
        self.bindDelegate = bindDelegate
    }
    
    open func refreshBindValue() {
//        guard let `bindDelegate` = bindDelegate, let `bindName` = bindName else { return }
//        guard let bindValue = bindDelegate.bindValue(bindName) as? Bool else { return }
//
//        isOn = bindValue
    }
    
    // MARK: - FormViewOnLoad
    open var onLoad: ((Any) -> Void)?
}
