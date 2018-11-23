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
        
        do {
            try buildForm()
        } catch {
            print("error: \(error)")
        }

    }
    
    func buildForm() throws {
        
        let _ = form
            .add(Form.field("name")
                .value("Name")
                .validators([
                    Former.minLength(minLength: 3, "SignUp.Name.Validation.BetweedLength.Error"),
                    Former.required("SignUp.Name.Validation.Required.Error")])
                .inlineValidator(Former.maxLength(maxLength: 6, "SignUp.Name.Validation.BetweedLength.Error"))
                .onChange({ (value) in
                    //                    guard let control = self.formView.control("testLabel4") as? FormLabelControl else { return }
                    //                    let _ = control.text("dddddd")
                })
            )
            .add(Form.field("email").value("email 1"))
            .add(Form.field("password").value("password 1"))
            .add(Form.field("prWay")
                .onChange({ (value) in
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
        //        try? formView.addGroup(Former.group().add(Former.textField("testLabelRow6").placeholder("test").bind("name")))
        try formView.addGroup(Former.group("g1")
            //            .header(
            //                Former.vertical().add([
            //                    Former.horizontal().add([
            //                        Former.label("testLabelRow1").isMain(true).onLoad({ (control) in
            //                            guard let `control` = control as? FormLabelControl else { return }
            //                            control.text = "pppp 1"
            //                        }),
            //                        Former.textField("testLabelRow2").placeholder("test")
            //                        ]),
            //                    Former.horizontal().add([
            //                        Former.label("testLabelRow3-1").text("test 1").bind("name").isMain(true),
            //                        Former.textField("testLabelRow4-1").placeholder("test").bind("name")
            //                        ])
            //                    ]).onLoad({ (_) in
            //                        guard let control = self.formView.control("testLabelRow1") as? FormLabelControl else { return }
            //                        control.text = "pppp 2"
            //                    })
            //            )
            .add(
                Former.vertical("g1:r1:v1").add([
                    Former.horizontal("g1:r1:v1:h1").add([
                        Former.label("testLabelRow1").text("test 1").isMain(true),
                        Former.textField("testLabelRow4").text("test 2").placeholder("test")
                        ]),
                    Former.horizontal("g1:r1:v1:h2").add([
                        Former.label("testLabelRow2").text("test 3").isMain(true),
                        Former.textField("testLabelRow6").placeholder("test").text("test 4")
                        ])
                    ])
            )
            //            .footer(Former.vertical().add(
            //                [
            //                    Former.horizontal().add([
            //                        Former.label("testLabelRow9").text("test 1").bind("name").isMain(true),
            //                        Former.textField("testLabelRow10").placeholder("test").bind("name")
            //                        ]),
            //                    Former.horizontal().add([
            //                        Former.label("testLabelRow11").text("test 1").bind("name").isMain(true),
            //                        Former.textField("testLabelRow12").placeholder("test").bind("name")
            //                        ])
            //                ]))
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

