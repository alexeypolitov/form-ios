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
    func updateControlLayout(element: FormControllable) //, withoutReload: Bool)
}

protocol FormSizeable {
    var fixedWidth: CGFloat? { get set }
    var fixedHeigth: CGFloat? { get set }
}

protocol FormControllable {    
    var isMain: Bool { get set }
    var name: String { get }

    var layoutDelegate: FormStackControlElementLayoutDelegate? { get set }
    func layoutDelegate(_ layoutDelegate: FormStackControlElementLayoutDelegate?)
}

