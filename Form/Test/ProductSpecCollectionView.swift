//
//  ProductSpecCollectionView.swift
//  BearClerk
//
//  Created by Alexey Politov on 2018/12/04.
//  Copyright © 2018 Section 9. All rights reserved.
//

import UIKit

struct ProductSpecCollectionViewItem {
    var title: String
    var detail: String
}

class ProductSpecCollectionView: FormViewVerticalContainer {
    
    static let fixedTitleWidth: CGFloat = 90
    
    public var items: [ProductSpecCollectionViewItem] = [] {
        didSet {
            buildItems()
        }
    }
    
    override init(_ name: String, _ initializer: @escaping (ProductSpecCollectionView) -> Void) {
        super.init(name)
        self.backgroundColor = UIColor.black
        self.insets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        self.minimalInset = 2
        initializer(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    func buildItems() {
        
        var tmpControls: [FormViewControllable] = []
        
        for item in items {
            
//            let container = FormViewHorizontalContainer() { container in
//                container.minimalInset = 2
//                container +++ FormViewLabel() { label in
//                    label.insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//                    label.backgroundColor = UIColor.white
//                    label.text = item.title
//                    label.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
//                    label.numberOfLines = 0
//                    label.fixedWidth = ProductSpecCollectionView.fixedTitleWidth
//                }
//                container +++ FormViewLabel() { label in
//                    label.insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//                    label.backgroundColor = UIColor.white
//                    label.isMain = true
//                    label.numberOfLines = 0
//                    label.text = item.detail
//                    label.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
//                }
//            }
//            tmpControls.append(container)
            
            let control = FormViewLabel() { label in
//                label.insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
                label.backgroundColor = UIColor.white
//                label.isMain = true
                label.numberOfLines = 0
                label.text = item.detail
                label.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
            }
            tmpControls.append(control)
            
        }
        
        self.controls = tmpControls
    }
    
}
