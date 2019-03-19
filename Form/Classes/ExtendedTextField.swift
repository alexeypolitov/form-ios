//
//  ExtendedTextField.swift
//  Form
//
//  Created by Alexey Politov on 2019/03/19.
//  Copyright © 2019 Alexey Politov. All rights reserved.
//

import UIKit

open class ExtendedTextField: UITextField {
    
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
        
    }
    
}
