//
//  FormViewBadge.swift
//  Form
//
//  Created by Alexey Politov on 2019/04/10.
//  Copyright © 2019 Alexey Politov. All rights reserved.
//

import UIKit

open class FormViewBadge: UIView, FormViewControllable {
    
    open lazy var label: ExtendedLabel = {
        let label = ExtendedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 2)
        
        return label
    }()
    
    public var isMain: Bool = false
    public let name: String
    public var layoutDelegate: FormViewLayoutable?
    
    open var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
            layoutDelegate?.updateControlLayout(element: self)
        }
    }
    
    open var attributedText: NSAttributedString? {
        get {
            return label.attributedText
        }
        set {
            label.attributedText = newValue
            layoutDelegate?.updateControlLayout(element: self)
        }
    }
    
    open var numberOfLines: Int {
        get {
            return label.numberOfLines
        }
        set {
            label.numberOfLines = newValue
            layoutDelegate?.updateControlLayout(element: self)
        }
    }
    
    open var textColor: UIColor {
        get {
            return label.textColor
        }
        set {
            label.textColor = newValue
        }
    }
    
    open var textAlignment: NSTextAlignment {
        get {
            return label.textAlignment
        }
        set {
            label.textAlignment = newValue
        }
    }
    
    open var font: UIFont {
        get {
            return label.font
        }
        set {
            label.font = newValue
            layoutDelegate?.updateControlLayout(element: self)
        }
    }
    
    open var insets: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            updateLabel()
        }
        
    }
    
    open var borderColor: CGColor? {
        get {
            return self.layer.borderColor
        }
        set {
            self.layer.borderColor = newValue
        }
    }
    
    open var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    open var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    open override func setContentHuggingPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        super.setContentHuggingPriority(priority, for: axis)
        label.setContentHuggingPriority(priority, for: axis)
    }
    
    private var labelLeftAnchorConstraint: NSLayoutConstraint?
    private var labelRightAnchorConstraint: NSLayoutConstraint?
    private var labelTopAnchorConstraint: NSLayoutConstraint?
    private var labelBottomAnchorConstraint: NSLayoutConstraint?
    
    public init(_ name: String = UUID().uuidString, _ initializer: @escaping (FormViewBadge) -> Void = { _ in }) {
        self.name = name
        
        super.init(frame: CGRect.zero)
        
        self.insets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        self.cornerRadius = 5
        
        prepareLayout()
        
        initializer(self)

    }
    
    public override init(frame: CGRect) {
        fatalError("Use init()")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    private func prepareLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        
        addSubview(label)
        
        labelLeftAnchorConstraint = label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: insets.left)
        labelLeftAnchorConstraint?.isActive = true
        labelTopAnchorConstraint = label.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top)
        labelTopAnchorConstraint?.isActive = true
//        labelRightAnchorConstraint = label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -insets.right)
//        labelRightAnchorConstraint?.isActive = true
        labelRightAnchorConstraint = label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -insets.right)
        labelRightAnchorConstraint?.isActive = true
        labelBottomAnchorConstraint = label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -insets.bottom)
        labelBottomAnchorConstraint?.isActive = true
    }
    
    private func updateLabel() {
        labelLeftAnchorConstraint?.constant = insets.left
        labelTopAnchorConstraint?.constant = insets.top
        labelRightAnchorConstraint?.constant = -insets.right
        labelBottomAnchorConstraint?.constant = -insets.bottom
        
        self.layoutIfNeeded()
    }
    
    open func layoutDelegate(_ layoutDelegate: FormViewLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
}

