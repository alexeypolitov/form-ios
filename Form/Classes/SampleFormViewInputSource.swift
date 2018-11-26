//
//  SampleFormViewKeyboard.swift
//  Form
//
//  Created by Alexey Politov on 2018/11/24.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

public class SampleFormViewInputSource: FormViewInputSource {

    public lazy var label: ExtendedLabel = {
        return ExtendedLabel()
    }()
    
    public lazy var doneButtonItem: ExtandedUIBarButtonItem = {
        return ExtandedUIBarButtonItem(title: "Done", style: .plain, target: nil, action: nil)
    }()
    
    public lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        toolbar.setItems([UIBarButtonItem(customView: label), UIBarButtonItem.flexibleSpace(),doneButtonItem], animated: false)
        
        return toolbar
    }()
    
    public lazy var datepicker: UIDatePicker = {
        let datepicker = UIDatePicker()
        datepicker.translatesAutoresizingMaskIntoConstraints = false
        
        return datepicker
    }()
    
    public override var inputAccessoryView: UIView? {
        get { return toolbar }
        set { }
    }
    
//    override var inputView: UIView? {
//        get { return datepicker }
//        set { }
//    }

}
