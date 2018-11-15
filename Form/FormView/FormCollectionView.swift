//
//  FormCollectionTableViewHeaderFooterView.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/17.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

protocol FormCollectionViewDataSource {
    func numberOfItems() -> Int
    func formCollectionView(itemAt index:Int) -> FormCollectionItem
}

open class FormCollectionView: UITableViewHeaderFooterView {

    var collectionView: UICollectionView?
    var dataSource: FormCollectionViewDataSource? {
        didSet {
            for index in 0...(dataSource?.numberOfItems() ?? 0) - 1 {
                if let collectionItem = dataSource?.formCollectionView(itemAt: index) {
                    register(collectionItem.cellClass, nibName: collectionItem.nibName)
                }
            }
            collectionView?.reloadData()
        }
    }
    
    fileprivate var registredIdentifiers: [String: AnyClass] = [:]
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        
        cv.backgroundColor = .clear
        
        addSubview(cv)
        
        cv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        cv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        cv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        collectionView = cv
        
        register(UICollectionViewCell.self)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func register(_ cellClass: AnyClass, nibName: String? = nil) {
        let reuseIdentifier = nibName ?? String(describing: cellClass.self)
        
        if let _ = registredIdentifiers[reuseIdentifier] {
            // do nothing
        } else {
            
            if let `nibName` = nibName {
                collectionView?.register(UINib(nibName: `nibName`, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
            } else {
                collectionView?.register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
            }
            registredIdentifiers[reuseIdentifier] = cellClass
        }
    }

}

// MARK: - UICollectionViewDataSource

extension FormCollectionView: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfItems() ?? 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource != nil ? 1 : 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let collectionItem = dataSource?.formCollectionView(itemAt: indexPath.section) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionItem.nibName ?? String(describing: collectionItem.cellClass.self), for: indexPath)
            
            collectionItem.prepare(cell: cell)
            
            return cell
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UICollectionViewCell.self), for: indexPath)
        }
        
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FormCollectionView: UICollectionViewDelegateFlowLayout {
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return dataSource?.formCollectionView(itemAt: indexPath.section).size(maxWidth: collectionView.frame.width) ?? CGSize.zero
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let collectionItem = dataSource?.formCollectionView(itemAt: section) {
            return collectionItem.insets
        } else {
            return UIEdgeInsets.zero
        }
    }
    
}

// MARK: - UICollectionViewDelegate

extension FormCollectionView: UICollectionViewDelegate {
    
}
