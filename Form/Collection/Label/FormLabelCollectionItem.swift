//
//  FormLabelCollectionItem.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/18.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormLabelCollectionItem: FormCollectionItem {
    
    var text: String? { //NSAttributedString?
        didSet {
            
        }
    }
    var textAlignment: NSTextAlignment = NSTextAlignment.left {
        didSet {
            
        }
    }
    override var insets: UIEdgeInsets {
        didSet {
            
        }
    }
    
    init(_ name: String = UUID().uuidString, text: String? = nil, textAlignment: NSTextAlignment = .left, insets: UIEdgeInsets = .zero) {
//        if let `text` = text {
//            self.text = NSAttributedString(string: text, attributes: FormLabelCollectionItem.defaultTextStyle())
//        }
        self.text = text
        self.textAlignment = textAlignment
        
        super.init(name: name, insets: insets)
    }
    
    // MARK: - Cell
    
    open override var cellClass: UICollectionViewCell.Type {
        return FormLabelCollectionItemCell.self
    }
    
    open override func size(maxWidth: CGFloat) -> CGSize {
        return CGSize(width: maxWidth - (insets.left + insets.right), height: 20)
    }
    
    // MARK: - Preparation
    
    open override func prepare(cell: UICollectionViewCell) {
        super.prepare(cell: cell)
        
        guard let `cell` = cell as? FormLabelCollectionItemCell else {
            return
        }

        cell.formTextLabel.text = text
//        cell.formTextLabel.attributedText = text
        cell.formTextLabel.textAlignment = textAlignment
        
    }
    
    // MARK: - Style
    
    open class func defaultTextStyle() -> [NSAttributedString.Key: Any] {
        return [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        ]
    }
}

// MARK: - Setters

extension FormLabelCollectionItem {
    
    func text(_ text: String) -> FormLabelCollectionItem {
        self.text = text
        return self
    }
    
    func textAlignment(_ textAlignment: NSTextAlignment) -> FormLabelCollectionItem {
        self.textAlignment = textAlignment
        return self
    }
    
    func insets(_ insets: UIEdgeInsets) -> FormLabelCollectionItem {
        self.insets = insets
        return self
    }
    
}
