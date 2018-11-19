//
//  FormControlCell.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/18.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class OldFormControlCell: UITableViewCell {

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        buildLayout()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Layout
    
    open func buildLayout() {
        
    }

}
