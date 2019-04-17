//
//  ProductSpecCollectionViewItem.swift
//  Form
//
//  Created by Alexey Politov on 2019/04/16.
//  Copyright © 2019 Alexey Politov. All rights reserved.
//

import UIKit

class ProductSpecCollectionViewItemCell: UICollectionViewCell {
    
    static let font: UIFont = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
    static let insert: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    static func height(text: String, withConstrainedWidth: CGFloat) -> CGFloat {
        var height = text.height(withConstrainedWidth: withConstrainedWidth - (ProductSpecCollectionViewItemCell.insert.left + ProductSpecCollectionViewItemCell.insert.right), font: ProductSpecCollectionViewItemCell.font)
        height += ProductSpecCollectionViewItemCell.insert.top + ProductSpecCollectionViewItemCell.insert.bottom
        return height
    }
    
    public lazy var label: ExtendedLabel = {
        let label = ExtendedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = ProductSpecCollectionViewItemCell.font
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        addSubview(label)
        
        addFormConstrain(label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: ProductSpecCollectionViewItemCell.insert.left))
        addFormConstrain(label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -ProductSpecCollectionViewItemCell.insert.right))
        addFormConstrain(label.topAnchor.constraint(equalTo: self.topAnchor, constant: ProductSpecCollectionViewItemCell.insert.top))
        addFormConstrain(label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -ProductSpecCollectionViewItemCell.insert.bottom))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addFormConstrain(_ constraint: NSLayoutConstraint, priority: UILayoutPriority? = nil) {
        if let `priority` = priority {
            constraint.priority = priority
        } else {
            constraint.priority = .defaultHigh
        }
        constraint.isActive = true
    }
    
}
