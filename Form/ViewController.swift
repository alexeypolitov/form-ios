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

        // without container
//        let group = Form.group()
//            .header(
//                Form.label("textLabel1")
//                    .text("Some label 1")
//                    .numberOfLines(0))
//            .add(Form.label("textLabel2").text("Some label 2"))
//            .add(Form.label("textLabel3").text("Some label 3"))
//            .add(Form.label("textLabel4").text("Some label 4"))
        
        // test stackview
        let horizontalContainer = Form.horizontal()
            .add(Form.label("test1").text("test 1"))
            .add(Form.label("test2").text("test 2").isMain(true))
            .add(Form.label("test3").text("test 3"))
        
        let verticalContainer = Form.vertical()
            .add(horizontalContainer)
            .add(Form.label("test4").text("test 4").textHorizontalAlignment(.right))
            .add(Form.label("test5").text("test 5"))
        
        
        
        
        // with container
        let group = Form.group()
//            .add(Form.textView("textLabel").text("Some label 1"))
            .add(verticalContainer)
            .header(
                Form.vertical()
                    .add(
                        Form.horizontal()
                            .add(Form.label("test1").text("test 1"))
                            .add(Form.label("test2").text("test 2").isMain(true))
                            .add(Form.label("test3").text("test 3"))
                    )
                    .add(Form.label("test4").text("test 4").textHorizontalAlignment(.right))
                    .add(Form.label("test5").text("test 5")))

        try? formView.addGroup(group)
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
            guard let collection = self.formView.collection("header1") as? FormHeaderFooterContainer else { return }
            guard let element = collection.element as? FormLabelControl else { return }
            
            element.text = "Test\ntest\ntest\ntest"
            
//            guard let control = self.formView.control(name: "testStackControl") as? FormStackControl else { return }
//            guard let element = control.element(by: "textLabel") as? FormLabelStackControlElement else { return }
//
//            element.text = "sdfdsfkldsjflkdsjfdlksjflkfdsjkfjdslkfjdslfjdslfjslfjljfdslfjdslfj"
            
//            control.formLabel.text = "Some text"
            
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

