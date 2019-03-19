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
    
    open lazy var bottomBorder: UIView = {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.isUserInteractionEnabled = false
        border.backgroundColor = UIColor.clear
        
        return border
    }()
    
    open lazy var topBorder: UIView = {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.isUserInteractionEnabled = false
        border.backgroundColor = UIColor.clear
        
        return border
    }()
    
    open lazy var leftBorder: UIView = {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.isUserInteractionEnabled = false
        border.backgroundColor = UIColor.clear
        
        return border
    }()
    
    open lazy var rightBorder: UIView = {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.isUserInteractionEnabled = false
        border.backgroundColor = UIColor.clear
        
        return border
    }()
    
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
        
        placeholderLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        placeholderLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        placeholderLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        addSubview(bottomBorder)
        
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(greaterThanOrEqualToConstant: 0.5).isActive = true
        
        addSubview(topBorder)
        
        topBorder.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        topBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        topBorder.heightAnchor.constraint(greaterThanOrEqualToConstant: 0.5).isActive = true
        
        addSubview(leftBorder)
        
        leftBorder.topAnchor.constraint(equalTo: topAnchor).isActive = true
        leftBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        leftBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        leftBorder.widthAnchor.constraint(greaterThanOrEqualToConstant: 0.5).isActive = true
        
        addSubview(rightBorder)
        
        rightBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        rightBorder.topAnchor.constraint(equalTo: topAnchor).isActive = true
        rightBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        rightBorder.widthAnchor.constraint(greaterThanOrEqualToConstant: 0.5).isActive = true
        
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
