//
//  FormGroup.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/17.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import Foundation

open class FormGroup {
    var headerCollection: FormHeaderFooter?
    var controls: [FormControl] = []
    var footerCollection: FormCollection?
    
    init(header: FormHeaderFooter? = nil, _ controls: [FormControl] = [], footer: FormCollection? = nil) {
        self.headerCollection = header
        self.controls = controls
        self.footerCollection = footer
    }
}

class FormDefaultGroup: FormGroup {
    
}
