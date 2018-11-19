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

        
        // with container
        let group = Form.group()
            .add(Form.vertical()
                .add(Form.textView("textView").placeholder("Enter some text").onChange({(control, string) in
                    guard let limitLabel = self.formView.control("testLimit") as? FormLabelControl else { return }
                    
                    limitLabel.text("\(string?.count ?? 0)/100")
                }))
                .add(Form.label("testLimit").text("0/100").textHorizontalAlignment(.right)))
        
        

        
        do {
            try formView.addGroup(group)
        } catch {
            print("error: \(error)")
        }
//        try? formView.addControl(control)
        
    }
    
//    func editLabelDetailText(control: FormLabelControl) {
//
////        let alert = UIAlertController(title: "Detail Text", message: nil, preferredStyle: .alert)
////
////        alert.addTextField { (textField:UITextField) in
////            textField.placeholder = "detail"
////            textField.text = control.formDetailTextLabel.text
////        }
////
////        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
////            guard let text =  alert.textFields?.first?.text else { return }
////
////            if text.count > 0 {
////                control.formDetailTextLabel.text = text
////            } else {
////                control.formDetailTextLabel.text = nil
////            }
////
////
////        }))
////        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
////
////        self.present(alert, animated: true, completion: nil)
//
//    }

    @objc func onAction(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Change textLabel", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }
            guard let control = self.formView.control("test1") as? FormLabelControl else { return }
            
//            guard let collection = self.formView.collection("header1") as? FormHeaderFooterContainer else { return }
//            guard let element = collection.element as? FormLabelControl else { return }
            
            control.text = "Test\ntest\ntest\ntest"
            
        }))
        
//        actionSheet.addAction(UIAlertAction(title: "Remove label", style: .default, handler: { [weak self] (action) in
//            guard let `self` = self else { return }
//            guard let control = self.formView.control(name: "textField1") as? FormTextFieldControl else { return }
//
//            control.formLabel.text = nil
//
//        }))
        
        actionSheet.addAction(UIAlertAction(title: "Reload", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }
            
            self.formView.reloadData()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }

}

