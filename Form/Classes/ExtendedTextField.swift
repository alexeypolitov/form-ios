//
//  ExtendedTextField.swift
//  Form
//
//  Created by Alexey Politov on 2019/03/19.
//  Copyright © 2019 Alexey Politov. All rights reserved.
//

import UIKit

open class ExtendedTextField: UITextField {

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
        super.init(frame: CGRect.zero)
        prepareLayout()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareLayout()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        prepareLayout()
    }
    
    private func prepareLayout() {
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
//        rightBorder.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
    
}
