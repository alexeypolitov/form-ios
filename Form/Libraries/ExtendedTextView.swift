//
//  PlaceholderTextView.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/18.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class ExtendedTextView: UITextView {

    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    var placeholderColor:UIColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    
    // MARK: - LifeCycle
    
    init() {
        super.init(frame: CGRect.zero, textContainer: nil)
        awakeFromNib()
        updateLayout()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.onTextDidChange(notification:)), name: UITextView.textDidChangeNotification, object: self)
        
        addSubview(placeholderLabel)
        
        placeholderLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        placeholderLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        placeholderLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
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
