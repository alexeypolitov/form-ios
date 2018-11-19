//
//  FormControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/17.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

@objc protocol FormControlSelectable: NSObjectProtocol {
    var selectionStyle: UITableViewCell.SelectionStyle { get set }
    var accessoryType: UITableViewCell.AccessoryType { get set }
    @objc func formControlOnSelect()
}

open class OldFormControl: NSObject {
    
    open var cellClass: UITableViewCell.Type { return UITableViewCell.self }
    open weak var linkedCell: UITableViewCell?
    let name: String    
    
    init(name: String = UUID().uuidString) {
        self.name = name
    }
    
    open func prepare(cell: UITableViewCell) {
        linkedCell = cell        
    }
    
    func updateFormView() {
        guard let formView = linkedCell?.superview?.superview as? FormView else { return }
        formView.updateControls()
    }
}
