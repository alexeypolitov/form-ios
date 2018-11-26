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
        
//        let _ = form
//            .add(Form.field("name")
//                .value("Name")
//                .validators([
//                    Former.minLength(minLength: 3, "SignUp.Name.Validation.BetweedLength.Error"),
//                    Former.required("SignUp.Name.Validation.Required.Error"),
//                    Former.maxLength(maxLength: 6, "SignUp.Name.Validation.BetweedLength.Error")])
//                .onChange({ (value) in
////                    print("value: \(value ?? "{NIL}")")
//                })
//            )
//            .add(Form.field("email").value("email 1"))
//            .add(Form.field("password").value("password 1"))
//            .add(Form.field("prWay")
//                .onChange({ (value) in
//                    guard let control = self.formView.control("prWayLabel") as? FormLabelControl else { return }
//                    if value != nil {
//                        let _ = control.text("Value \(value!)")
//                    } else {
//                        let _ = control.text("選択してください")
//                    }
//
//                })
//        )
        
        let _ = form
            .add(Form.field("name")
                .validators([
                    Former.required("SignUp.Name.Validation.Required.Error"),
                    Former.between(minLength: 3, maxLength: 20, "SignUp.Name.Validation.BetweedLength.Error")])
                .onChange({ (value) in
                    guard let control = self.formView.control("nameTextField") as? FormViewTextField else { return }
                    guard let inputSource = control.inputSource as? SampleFormViewInputSource else { return }
                    inputSource.label.text = "\(value ?? "")"
                    inputSource.label.sizeToFit()
//                    print(inputSource.label)
//                    print(inputSource.toolbar.items?.first)
//                    inputSource.toolbar.setNeedsUpdateConstraints()
                    
//                    let test3 = UIBarButtonItem(title: "test", style: .plain, target: nil, action: nil)
//                    inputSource.toolbar.setItems([test3], animated: false)
                    
                    print("name - onChange")
                })
        )
        .add(Form.field("email")
            .validators([
                Former.required("SignUp.Email.Validation.Required.Error"),
                Former.email("SignUp.Email.Validation.Email.Error")])
            .onChange({ (value) in
                print("email - onChange")
            })
        )
        .add(Form.field("password")
            .validators([
                Former.required("SignUp.Password.Validation.Required.Error"),
                Former.minLength(minLength: 6, "SignUp.Password.Validation.MinLength.Error")])
            .onChange({ (value) in
                print("password - onChange")
            })
        )
        .add(Form.field("prWay")
            .validator(Former.required("SignUp.PRWay.Validation.Required.Error"))
            .onChange({ (value) in
                print("prWay - onChange")
//                    guard let control = self.formView.control("prWayLabel") as? FormLabelControl else { return }
//                    if value != nil {
//                        let _ = control.text("Value \(value!)")
//                    } else {
//                        let _ = control.text("選択してください")
//                    }

            })
        )
        .add(Form.field("terms")
            .value(false)
            .validator(Former.required("SignUp.Terms.Validation.Required.Error"))
            .onChange({ (value) in
                print("terms - onChange")
            })
        )
        
        // FormView
        let sampleInputSource = SampleFormViewInputSource()
        
        let html = "<table width=\"100%\"> <tr> <td align=\"left\">Left string</td> <td align=\"right\">Right string</td></tr></table>"
        let attrtest = try NSAttributedString(data: html.data(using: .utf8)!, options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
        
        let _ = formView.bind(form)
        //        try? formView.addGroup(Former.group().add(Former.textField("testLabelRow6").placeholder("test").bind("name")))
        try formView.addGroup(Former.group("g1")
//            .header(
//                Former.vertical().add([
//                    Former.horizontal().add([
//                        Former.label("label1").isMain(true),
//                        Former.textField("text1").placeholder("test")
//                        ]),
//                    Former.horizontal().add([
//                        Former.label("label2").text("test 1").bind("name").isMain(true),
//                        Former.textField("test2").placeholder("test").bind("name")
//                        ])
//                    ])
//            )
            .add(
                Former.horizontal().add([
//                    Former.label("label3")
//                        .text("dsfdssfsdfsdf")
//                        .isMain(true)
////                        .inputSource(test)
//                        .onLoad({ (control) in
////                            guard let `control` = control as? FormViewLabel else { return }
////                            control.inputAccessoryView = test.inputAccessoryView
////                            control.inputView = test.inputView
//                        }),
                    Former.textField("nameTextField")
//                        .placeholder("Enter name")
                        .attributedPlaceholder(attrtest)
//                        .textAlignment(.right)                        
                        .bind("name")
                        .isMain(true)
                        .backgroundColor(UIColor.yellow)
                        .inputSource(sampleInputSource)
                        .onLoad({ (control) in
//                            guard let `control` = control as? FormViewTextField else { return }
                            
                        })
                    ])

            )
//            .add(
//                Former.vertical().add([
//                    Former.horizontal().add([
//                        Former.label("label3").text("test 1").isMain(true),
//                        Former.textField("test3").text("test 2").placeholder("test")
//                        ]),
//                    Former.horizontal().add([
//                        Former.label("label4").text("test 3").isMain(true),
//                        Former.textField("test4").placeholder("test").text("test 4")
//                        ])
//                    ])
//            )
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

