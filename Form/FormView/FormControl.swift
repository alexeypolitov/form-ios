//
//  FormControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/17.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class FormControl: NSObject {
    
    open var cellClass: UITableViewCell.Type { return UITableViewCell.self }
    open weak var linkedCell: UITableViewCell?
    let name: String
    
    init(name: String = UUID().uuidString) {
        self.name = name
    }
    
    open func prepare(cell: UITableViewCell) {
        linkedCell = cell        
    }
}
