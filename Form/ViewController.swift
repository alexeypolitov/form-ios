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
    var form: Form = Form()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Actions", style: .plain, target: self, action: #selector(self.onAction(_:)))
        
        let _ = form
            .add(Form.field("name")
                .value("Name")
                .validators([
                    Former.minLength(minLength: 3, "SignUp.Name.Validation.BetweedLength.Error"),
                    Former.required("SignUp.Name.Validation.Required.Error")])
                .inlineValidator(Former.maxLength(maxLength: 6, "SignUp.Name.Validation.BetweedLength.Error"))
                .onChange({ (value, status) in
//                    guard let control = self.formView.control("testLabel4") as? FormLabelControl else { return }
//                    let _ = control.text("dddddd")
                })
            )
            .add(Form.field("email").value("email 1"))
            .add(Form.field("password").value("password 1"))
            .add(Form.field("prWay")
                .onChange({ (value, status) in
                    guard let control = self.formView.control("prWayLabel") as? FormLabelControl else { return }
                    if value != nil {
                        let _ = control.text("Value \(value!)")
                    } else {
                        let _ = control.text("選択してください")
                    }

                })
            )
        
        // FormView
        
        let _ = formView.bind(form)
        try? formView.addGroup(Former.group()
            .header(Former.vertical().add(
                [
                    Former.horizontal().add([
                        Former.label("testLabelRow1").text("test 1").bind("name").isMain(true),
                        Former.textField("testLabelRow2").placeholder("test").bind("name")
                    ]),
                    Former.horizontal().add([
                        Former.label("testLabelRow3").text("test 1").bind("name").isMain(true),
                        Former.textField("testLabelRow4").placeholder("test").bind("name")
                    ])
                ]))
            .add(Former.vertical().add(
                [
                    Former.horizontal().add([
                        Former.label("testLabelRow5").text("test 1").bind("name").isMain(true),
                        Former.textField("testLabelRow6").placeholder("test").bind("name")
                        ]),
                    Former.horizontal().add([
                        Former.label("testLabelRow7").text("test 1").bind("name").isMain(true),
                        Former.textField("testLabelRow8").placeholder("test").bind("name")
                        ])
                ]))
            .footer(Former.vertical().add(
                [
                    Former.horizontal().add([
                        Former.label("testLabelRow9").text("test 1").bind("name").isMain(true),
                        Former.textField("testLabelRow10").placeholder("test").bind("name")
                        ]),
                    Former.horizontal().add([
                        Former.label("testLabelRow11").text("test 1").bind("name").isMain(true),
                        Former.textField("testLabelRow12").placeholder("test").bind("name")
                        ])
                ]))
        )
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
        
        actionSheet.addAction(UIAlertAction(title: "Change textView", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }
            guard let emailField = self.form.field("email") else { return }
            guard let passwordField = self.form.field("password") else { return }

            emailField.value = "email 2"
            passwordField.value = "password 2"

        }))
        
//        actionSheet.addAction(UIAlertAction(title: "Test", style: .default, handler: { [weak self] (action) in
//            guard let `self` = self else { return }
//            guard let group = self.formView.storedGroups.first else { return }
//            guard let header = group.header as? FormHeaderFooterContainer else { return }
//            print("ppp 3: header:\(header); linkedView:\(header.linkedView)")
//            guard let headerView = header.linkedView as? FormHeaderFooterContainerView else { return }
//
////            print("ddd: \(headerView)\n\(headerView.contentView.subviews)")
//
//        }))
        
//        actionSheet.addAction(UIAlertAction(title: "Validate", style: .default, handler: { [weak self] (action) in
//            guard let `self` = self else { return }
//
//            let (success, message) = self.formView.validate()
//            if success {
//                print("Validation: OK")
//            } else {
//                print("Validation Error: \(message ?? "Unknown")")
//            }
//        }))
        
        actionSheet.addAction(UIAlertAction(title: "Reload", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }
            
            self.formView.reloadData()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }

}

