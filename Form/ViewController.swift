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
        
//        let label = FormLabelControl(name: "testLabel1", text: "Some text")
//        label.accessoryType = .disclosureIndicator
////        label.formTextLabel.backgroundColor = UIColor.green
////        label.formTextLabel.numberOfLines = 0
////        label.formDetailTextLabel.backgroundColor = UIColor.purple
////        label.formDetailTextLabel.numberOfLines = 0
//        label.selectionStyle = .default
//        label.onSelectHandler = { (control) in
//            self.onLabelSelected(control)
//        }
//        try? formView.addControl(label)
        
        let badge = FormBadgeLabelControl(name: "testbadgeLabel1", text: "Some text")
//        label.accessoryType = .disclosureIndicator
        //        label.formTextLabel.backgroundColor = UIColor.green
        //        label.formTextLabel.numberOfLines = 0
        //        label.formDetailTextLabel.backgroundColor = UIColor.purple
        //        label.formDetailTextLabel.numberOfLines = 0
        badge.selectionStyle = .default
        badge.onSelectHandler = { (control) in
            self.onBadgeLabelSelected(control)
        }
        
        print(badge.formBadgeLabel.font)
        print(badge.formTextLabel.font)
        
        
        try? formView.addControl(badge)
        
//        try? formView.addControl(FormLabelControl(name: "testLabel2", text: "Some text", detail: "Some detail"))
        
    }
    
    @objc func onLabelSelected(_ sender: Any) {
        
        guard let `control` = sender as? FormLabelControl else { return }
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Set text", style: .default, handler: { (action) in
            self.editLabelText(control: control)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Set detail text", style: .default, handler: { (action) in
            self.editLabelDetailText(control: control)
        }))
        
        if control.formDetailTextLabel.text != nil {

            actionSheet.addAction(UIAlertAction(title: "Remove detail", style: .default, handler: { (action) in
                control.formDetailTextLabel.text = nil
            }))
            
        }
        
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func onBadgeLabelSelected(_ sender: Any) {
        
        guard let `control` = sender as? FormBadgeLabelControl else { return }
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Set badge", style: .default, handler: { (action) in
            self.editLabelBadge(control: control)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Set text", style: .default, handler: { (action) in
            self.editLabelText(control: control)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Set detail text", style: .default, handler: { (action) in
            self.editLabelDetailText(control: control)
        }))
        
        if control.formDetailTextLabel.text != nil {
            
            actionSheet.addAction(UIAlertAction(title: "Remove detail", style: .default, handler: { (action) in
                control.formDetailTextLabel.text = nil
            }))
            
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func editLabelBadge(control: FormBadgeLabelControl) {
        
        let alert = UIAlertController(title: "Badge", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = "badge"
            textField.text = control.formBadgeLabel.text
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
            guard let text =  alert.textFields?.first?.text else { return }
            
            control.formBadgeLabel.text = text
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func editLabelText(control: FormLabelControl) {
        
        let alert = UIAlertController(title: "Text", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = "title"
            textField.text = control.formTextLabel.text
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
            guard let text =  alert.textFields?.first?.text else { return }

            control.formTextLabel.text = text
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func editLabelDetailText(control: FormLabelControl) {
        
        let alert = UIAlertController(title: "Detail Text", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = "detail"
            textField.text = control.formDetailTextLabel.text
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
            guard let text =  alert.textFields?.first?.text else { return }
            
            if text.count > 0 {
                control.formDetailTextLabel.text = text
            } else {
                control.formDetailTextLabel.text = nil
            }
            
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }

    @objc func onAction(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Reload", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }
            
            self.formView.reloadData()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }

}

