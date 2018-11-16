//
//  FormStackControlElement.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/15.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

//protocol FormStackControlElementDelegate {
//    func updateControl()
//    func buildLayout()
//}

protocol FormStackControlElementLayoutDelegate {
    func updateControlLayout(element: FormStackControlElement) //, withoutReload: Bool)
}

protocol FormStackControlElementSizing {
    var fixedWidth: CGFloat? { get set }
    var fixedHeigth: CGFloat? { get set }
}

protocol FormStackControlElement {
    
    var isMain: Bool { get set }
    var name: String { get }
//    var stackDelegate: FormStackControlElementDelegate? { get set }
    var layoutDelegate: FormStackControlElementLayoutDelegate? { get set }
    func layoutDelegate(_ layoutDelegate: FormStackControlElementLayoutDelegate?)
    
//    func prepareStackDelegate(delegate: FormStackControlElementDelegate)
    
}

