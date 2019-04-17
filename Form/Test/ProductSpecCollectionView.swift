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

class ProductSpecCollectionView: UIView, FormViewControllable {
    
    static let borderOffset: CGFloat = 2
    static let titleWidth: CGFloat = 90
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = UIColor.clear
        
        collectionView.register(ProductSpecCollectionViewItemCell.self, forCellWithReuseIdentifier: "Cell")
        
        return collectionView
    }()
    
    var collectionViewHeightConstraint: NSLayoutConstraint?
    
    public var isMain: Bool = false
    public var name: String = UUID().uuidString
    public var layoutDelegate: FormViewLayoutable?
    
    open func layoutDelegate(_ layoutDelegate: FormViewLayoutable?) {
        self.layoutDelegate = layoutDelegate
    }
    
    public var items: [ProductSpecCollectionViewItem] = [] {
        didSet {
            buildCollectionViewHeight()
        }
    }

    
    init(_ name: String = UUID().uuidString, _ initializer: @escaping (ProductSpecCollectionView) -> Void = { _ in }) {
        self.name = name
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.black
        
        buildView()
        initializer(self)
    }
    
    override init(frame: CGRect) {
        fatalError("Use init()")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        buildCollectionViewHeight()
    }
    
    func buildView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Collection view
        self.addSubview(collectionView)
        
        addFormConstrain(collectionView.leftAnchor.constraint(equalTo: self.leftAnchor))
        addFormConstrain(collectionView.rightAnchor.constraint(equalTo: self.rightAnchor))
        addFormConstrain(collectionView.topAnchor.constraint(equalTo: self.topAnchor))
        addFormConstrain(collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor))
        
    }
    
    private func addFormConstrain(_ constraint: NSLayoutConstraint, priority: UILayoutPriority? = nil) {
        if let `priority` = priority {
            constraint.priority = priority
        } else {
            constraint.priority = .defaultHigh
        }
        constraint.isActive = true
    }
    
    func buildCollectionViewHeight() {
        
        guard collectionView.frame.width > 0 else { return }
        
        var height: CGFloat = ProductSpecCollectionView.borderOffset
        
        
        for item in items {
            height += calculateItemHeight(item: item, collectionViewWidth: collectionView.frame.width)
            height += ProductSpecCollectionView.borderOffset
        }
        
        if collectionViewHeightConstraint?.constant == height {
//            print("\(height)")
            collectionView.reloadData()
            return
        }
        
        if collectionViewHeightConstraint == nil {
            collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: height)
            collectionViewHeightConstraint?.isActive = true
        } else {
            collectionViewHeightConstraint?.constant = height
            layoutDelegate?.updateControlLayout(element: self)
            layoutIfNeeded()
        }
        
        collectionView.reloadData()
        
        
    }
    
    func calculateItemHeight(item: ProductSpecCollectionViewItem, collectionViewWidth: CGFloat) -> CGFloat {
        var height: CGFloat = 0
        
        let titleHeight = ProductSpecCollectionViewItemCell.height(text: item.title, withConstrainedWidth: ProductSpecCollectionView.titleWidth)
        if titleHeight > height {
            height = titleHeight
        }
        
        let detailHeight = ProductSpecCollectionViewItemCell.height(text: item.detail, withConstrainedWidth: collectionViewWidth - (ProductSpecCollectionView.titleWidth + ProductSpecCollectionView.borderOffset * 3))
        if detailHeight > height {
            height = detailHeight
        }
        
        return height
    }
    
}

extension ProductSpecCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count > 0 ? items.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count > 0 ? 2 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProductSpecCollectionViewItemCell
        
        if indexPath.row == 0 {
            cell.label.text = items[indexPath.section].title
        } else {
            cell.label.text = items[indexPath.section].detail
        }
        
        return cell
    }
    
}

extension ProductSpecCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: ProductSpecCollectionView.borderOffset, left: ProductSpecCollectionView.borderOffset, bottom: 0, right: ProductSpecCollectionView.borderOffset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: ProductSpecCollectionView.titleWidth, height: calculateItemHeight(item: items[indexPath.section], collectionViewWidth: collectionView.frame.width))
        } else {
            var width = collectionView.frame.width
            width -= ProductSpecCollectionView.titleWidth
            width -= ProductSpecCollectionView.borderOffset * 3
            
            let height = calculateItemHeight(item: items[indexPath.section], collectionViewWidth: collectionView.frame.width)
            return CGSize(width: width, height: height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ProductSpecCollectionView.borderOffset
    }

}
