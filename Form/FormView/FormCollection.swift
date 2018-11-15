//
//  FormHeaderFooter.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/17.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit


class FormCollection: FormCollectionViewDataSource {
    
    var items: [FormCollectionItem] = []
    
    open var viewClass: FormCollectionView.Type {
        return FormCollectionView.self
    }
    
    init(_ items: [FormCollectionItem]) {
        self.items = items
    }
    
    open func height(maxWidth: CGFloat) -> CGFloat {
        var height: CGFloat = 0
        items.forEach { (item) in
            height += item.size(maxWidth: maxWidth).height + item.insets.top + item.insets.bottom
        }        
        return height
    }
    
    open func prepare(collectionView: FormCollectionView) {
        collectionView.dataSource = self
    }
    
    func item(name: String) -> FormCollectionItem? {
        return items.first(where: {$0.name == name})
    }
    
    // MARK: - FormCollectionViewDataSource
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func formCollectionView(itemAt index: Int) -> FormCollectionItem {
        return items[index]
    }
    
}

open class FormCollectionItem {
 
    var name: String
    var insets: UIEdgeInsets
    
    init(name: String = UUID().uuidString, insets: UIEdgeInsets = .zero) {
        self.name = name
        self.insets = insets
    }
    
    open func size(maxWidth: CGFloat) -> CGSize {
        return CGSize.zero
    }
    
    open weak var linkedCell: UICollectionViewCell?
    
    open var cellClass: UICollectionViewCell.Type {
        return UICollectionViewCell.self
    }
    
    open var nibName: String? {
        return nil
    }
    
    open func prepare(cell: UICollectionViewCell) {
        linkedCell = cell
    }
    
}



