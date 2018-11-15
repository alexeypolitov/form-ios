//
//  FormStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

protocol FormStackControlElementDelegate {
    func updateControl()
    func buildLayout()
}

protocol FormStackControlElementLayoutDelegate {
    func updateControlLayout(element: FormStackControlElement)
}

protocol FormStackControlElement {
    
    var isMain: Bool { get set }
    var name: String { get }
    var stackDelegate: FormStackControlElementDelegate? { get set }
    var layoutDelegate: FormStackControlElementLayoutDelegate? { get set }
    
    func prepareStackDelegate(delegate: FormStackControlElementDelegate)
    
}

