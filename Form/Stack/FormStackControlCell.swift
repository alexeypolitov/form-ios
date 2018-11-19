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
    func element(at index: Int) -> FormControllable
    func elementsInsets() -> UIEdgeInsets
    func minimalInsetBetweenElements() -> CGFloat
}

class FormStackControlCell: OldFormControlCell {

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
        
        let insets = dataSource.elementsInsets()
        let minimalInset = dataSource.minimalInsetBetweenElements()
        
        var lastElement: FormControllable?
        for index in 0...dataSource.numberOfElements() - 1 {
            let element = dataSource.element(at: index)
            
            guard let elementView = element as? UIView else {
                fatalError("Unexpected class: \(String(describing: element.self))")
                continue
            }
            
            contentView.addSubview(elementView)
            
            storeConstrain(view: elementView, constrain: elementView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: insets.top))
            storeConstrain(view: elementView, constrain: elementView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: insets.bottom * -1))
            
            if let elementSizing = element as? FormStackControlElementSizing {
                if let fixedHeigth = elementSizing.fixedHeigth {
                    storeConstrain(view: elementView, constrain: elementView.heightAnchor.constraint(equalToConstant: fixedHeigth))
                }
                if let fixedWidth = elementSizing.fixedWidth {
                    storeConstrain(view: elementView, constrain: elementView.widthAnchor.constraint(equalToConstant: fixedWidth))
                }
            }
            
            
            if let lastElementView = lastElement as? UIView {
                storeConstrain(view: elementView, constrain: elementView.leftAnchor.constraint(equalTo: lastElementView.rightAnchor, constant: minimalInset))
            } else {
                storeConstrain(view: elementView, constrain: elementView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: insets.left))
            }
            
            if element.isMain {
                elementView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
            } else {
                elementView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
            }
            
            // is last
            if dataSource.numberOfElements() - 1 == index {
                if let elementSizing = element as? FormStackControlElementSizing, elementSizing.fixedWidth != nil {
                    // do noting
                } else {
                  storeConstrain(view: elementView, constrain: elementView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: insets.right * -1))
                }
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
