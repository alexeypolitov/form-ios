//
//  FormStockControlCell.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/18.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

protocol FormStackControlCellDataSource {
    func numberOfElements() -> Int
    func element(at index: Int) -> FormStackControlElement
}

class FormStackControlCell: FormControlCell {

    class StoredConstrain {
        let view: UIView
        var constrains: [NSLayoutConstraint]
        
        init(view: UIView, constrains: [NSLayoutConstraint]) {
            self.view = view
            self.constrains = constrains
        }
    }
    
    var dataSource: FormStackControlCellDataSource? {
        didSet {
            buildLayout()
        }
    }
    private var storedConstrains:[StoredConstrain] = []
    
    // MARK: - Layout
    
    override func buildLayout() {
        
        guard let `dataSource` = dataSource else {
            return
        }
        
        removeStoredConstrains()
        
        var lastElement: FormStackControlElement?
        for index in 0...dataSource.numberOfElements() - 1 {
            let element = dataSource.element(at: index)
            
            guard let elementView = element as? UIView else {
                fatalError("Unexpected class: \(String(describing: element.self))")
                continue
            }
            
            contentView.addSubview(elementView)
            
            storeConstrain(view: elementView, constrain: elementView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 14))
            storeConstrain(view: elementView, constrain: elementView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -14))
            
            if let lastElementView = lastElement as? UIView {
                storeConstrain(view: elementView, constrain: elementView.leftAnchor.constraint(equalTo: lastElementView.rightAnchor, constant: 8))
            } else {
                storeConstrain(view: elementView, constrain: elementView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16))
            }
            
            if element.isMain {
                elementView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
            } else {
                elementView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
            }
            
            // is last
            if dataSource.numberOfElements() - 1 == index {
                storeConstrain(view: elementView, constrain: elementView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16))
            }
            
            lastElement = element
            
        }
                        
    }
    
    private func storeConstrain(view: UIView, constrain: NSLayoutConstraint) {
        constrain.isActive = true
        if let stored = storedConstrains.first(where: {$0.view == view}) {
            stored.constrains.append(constrain)
        } else {
            storedConstrains.append(StoredConstrain(view: view, constrains: [constrain]))
        }
    }
    
    private func removeStoredConstrains() {
        
        for storedConstrain in storedConstrains {
            
            for constrain in storedConstrain.constrains {
                storedConstrain.view.removeConstraint(constrain)
            }
            
            if storedConstrain.view != self.contentView {
                storedConstrain.view.removeFromSuperview()
            }
            
        }
        
        storedConstrains = []
        
    }

}
