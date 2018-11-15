//
//  FormLabelCollectionItemCell.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/18.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

class FormLabelCollectionItemCell: FormCollectionItemCell {
 
    lazy var formTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        return label
    }()
    
    // MARK: - Layout
    
    override func buildLayout() {
        
        if formTextLabel.superview == nil {
            contentView.addSubview(formTextLabel)
        }
        
        contentView.removeConstraints(contentView.constraints)
        formTextLabel.removeConstraints(formTextLabel.constraints)
        
        formTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        formTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        formTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        formTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
}
