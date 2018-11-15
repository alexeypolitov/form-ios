//
//  ViewController.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/20.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var formView: FormView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Actions", style: .plain, target: self, action: #selector(self.onAction(_:)))
        
        let label = FormLabelControl(name: "testLabel1", text: "Some text")
        label.formTextLabel.backgroundColor = UIColor.green
        label.formDetailTextLabel.backgroundColor = UIColor.purple
        try? formView.addControl(label)
        
//        try? formView.addControl(FormLabelControl(name: "testLabel2", text: "Some text", detail: "Some detail"))
        
    }

    @objc func onAction(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Reload", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }
            
            self.formView.reloadData()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Add detail", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }
            guard let control = self.formView.control(name: "testLabel1") as? FormLabelControl else { return }
            
            control.formDetailTextLabel.text = "detail"
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Remove detail", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }
            guard let control = self.formView.control(name: "testLabel1") as? FormLabelControl else { return }
            
            control.formDetailTextLabel.text = nil
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }

}

