//
//  FormViewSegment.swift
//  Form
//
//  Created by Alexey Politov on 2019/02/28.
//  Copyright © 2019 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewSegmented: ExtendedSegmentedControl, FormViewControllable, FormViewBindable, FormViewOnLoad {
    
    public var isMain: Bool = false
    public let name: String
    public var layoutDelegate: FormViewLayoutable?
    
    open var onSelect: ((FormViewSegmented, UInt) -> Void)?
    open var onDiselect: ((FormViewSegmented, UInt) -> Void)?
    
    public override init(frame: CGRect) {
        fatalError("Use init()")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    public init(_ name: String = UUID().uuidString, _ initializer: @escaping (FormViewSegmented) -> Void = { _ in }) {
        self.name = name
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
//        self.delegate = self
        initializer(self)
    }
    
    open func layoutDelegate(_ layoutDelegate: FormViewLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
//    // MARK: - MultiSelectSegmentedControlDelegate
//    
//    public func multiSelect(_ multiSelectSegmentedControl: MultiSelectSegmentedControl, didChangeValue value: Bool, at index: UInt) {
//        if value {
//            onSelect?(self, index)
//        } else {
//            onDiselect?(self, index)
//        }
//    }
    
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
