//
//  FormCollectionItemCell.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/18.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormCollectionItemCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildLayout()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Layout
    
    open func buildLayout() {
        
    }
}
