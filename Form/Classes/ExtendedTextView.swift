//
//  PlaceholderTextView.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/18.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class ExtendedTextView: UITextView {

    open lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    open var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    open var placeholderColor:UIColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    
    open override var textContainerInset: UIEdgeInsets {
        didSet {
            updatePlaceholder()
        }
    }
    
    private var placeholderLabelLeftAnchorConstraint: NSLayoutConstraint?
    private var placeholderLabelRightAnchorConstraint: NSLayoutConstraint?
    private var placeholderLabelTopAnchorConstraint: NSLayoutConstraint?
    private var placeholderLabelBottomAnchorConstraint: NSLayoutConstraint?
    
    // MARK: - LifeCycle
    
    public init() {
        super.init(frame: CGRect.zero, textContainer: nil)
        prepareLayout()
        updateLayout()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        prepareLayout()
    }
    
    private func prepareLayout() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onTextDidChange(notification:)), name: UITextView.textDidChangeNotification, object: self)
        
        addSubview(placeholderLabel)
        
        placeholderLabelLeftAnchorConstraint = placeholderLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.textContainerInset.left)
        placeholderLabelLeftAnchorConstraint?.isActive = true
        placeholderLabelTopAnchorConstraint = placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.textContainerInset.top)
        placeholderLabelTopAnchorConstraint?.isActive = true
        placeholderLabelRightAnchorConstraint = placeholderLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: self.textContainerInset.right)
        placeholderLabelRightAnchorConstraint?.isActive = true
        placeholderLabelBottomAnchorConstraint = placeholderLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: self.textContainerInset.bottom)
        placeholderLabelBottomAnchorConstraint?.isActive = true
        
    }
    
    private func updatePlaceholder() {
        placeholderLabelLeftAnchorConstraint?.constant = self.textContainerInset.left
        placeholderLabelTopAnchorConstraint?.constant = self.textContainerInset.top
        placeholderLabelRightAnchorConstraint?.constant = self.textContainerInset.right
        placeholderLabelBottomAnchorConstraint?.constant = self.textContainerInset.bottom
        
        self.layoutIfNeeded()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        updateLayout()        
        
    }
    
    open override func updateConstraints() {
        super.updateConstraints()
    }

    private func updateLayout() {
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.font = self.font
        
        if (placeholderLabel.text == nil && placeholderLabel.attributedText == nil) || text.count > 0 {
            placeholderLabel.isHidden = true
        } else {
            placeholderLabel.isHidden = false
        }
    }
    
    @objc open func onTextDidChange(notification: Notification) {
        layoutSubviews()
    }
    
}
