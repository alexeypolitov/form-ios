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
                .value("Some name")
                .validators([
                    Former.minLength(minLength: 3, "SignUp.Name.Validation.BetweedLength.Error"),
                    Former.required("SignUp.Name.Validation.Required.Error")])
                .inlineValidator(Former.maxLength(maxLength: 20, "SignUp.Name.Validation.BetweedLength.Error"))
                .onChange({ (value, status) in
                    guard let control = self.formView.control("testLabel4") as? FormLabelControl else { return }
                    let _ = control.text("dddddd")
                })
            )
            .add(Form.field("test").value(true).onChange({ (value, status) in
                print("ddd: \(value)")
            }))
            .add(Form.field("email"))
            .add(Form.field("password"))
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
            .header(Former.label("testLabel1").text("1以下をご入力ください").numberOfLines(0).backgroundColor(UIColor.yellow))
            .add(Former.textField("nameTextField1").bind("name").placeholder("1氏名"))
            .add(Former.textView("emailTextField1").bind("name").placeholder("1メールアドレス"))
            .add(Former.switcher("passwordTextField1").bind("test"))
            .footer(Former.label().text("1パスワードは忘れないようにメモしましょう！").numberOfLines(0))
        )
        
//        try? formView.addGroup(Former.group()
//            .header(Former.label("testLabel2").text("2以下をご入力ください"))
//            .add(Former.textField("nameTextField2").bind("name").placeholder("2氏名"))
//            .add(Former.textField("emailTextField2").placeholder("2メールアドレス"))
//            .add(Former.textField("passwordTextField2").placeholder("2パスワード（半角英数字6字以上）"))
//            .footer(Former.label().text("2パスワードは忘れないようにメモしましょう！"))
//        )
//
//        try? formView.addGroup(Former.group()
//            .header(Former.label("testLabel3").text("3以下をご入力ください"))
//            .add(Former.textField("nameTextField3").bind("name").placeholder("3氏名"))
//            .add(Former.textField("emailTextField3").placeholder("3メールアドレス"))
//            .add(Former.textField("passwordTextField3").placeholder("3パスワード（半角英数字6字以上）"))
//            .footer(Former.label().text("3パスワードは忘れないようにメモしましょう！"))
//        )
//
//        try? formView.addGroup(Former.group()
//            .header(Former.label("testLabel4").text("4以下をご入力ください"))
//            .add(Former.textField("nameTextField4").bind("name").placeholder("4氏名"))
//            .add(Former.textField("emailTextField4").placeholder("4メールアドレス"))
//            .add(Former.textField("passwordTextField4").placeholder("4パスワード（半角英数字6字以上）"))
//            .footer(Former.label().text("4パスワードは忘れないようにメモしましょう！"))
//        )
//
//        try? formView.addGroup(Former.group()
//            .header(Former.label("testLabel5").text("5以下をご入力ください"))
//            .add(Former.textField("nameTextField5").bind("name").placeholder("5氏名"))
//            .add(Former.textField("emailTextField5").placeholder("5メールアドレス"))
//            .add(Former.textField("passwordTextField5").placeholder("5パスワード（半角英数字6字以上）"))
//            .footer(Former.label().text("5パスワードは忘れないようにメモしましょう！"))
//        )
//        try? formView.addGroup(Former.group()
//            .header(Former.label("testLabel6").text("6以下をご入力ください"))
//            .add(Former.textField("nameTextField6").bind("name").placeholder("6氏名"))
//            .add(Former.textField("emailTextField6").placeholder("6メールアドレス"))
//            .add(Former.textField("passwordTextField6").placeholder("6パスワード（半角英数字6字以上）"))
//            .footer(Former.label().text("6パスワードは忘れないようにメモしましょう！"))
//        )
//
//        try? formView.addGroup(Former.group()
//            .header(Former.label("testLabel7").text("7以下をご入力ください"))
//            .add(Former.textField("nameTextField7").bind("name").placeholder("7氏名"))
//            .add(Former.textField("emailTextField7").placeholder("7メールアドレス"))
//            .add(Former.textField("passwordTextField7").placeholder("7パスワード（半角英数字6字以上）"))
//            .footer(Former.label().text("7パスワードは忘れないようにメモしましょう！"))
//        )
//
//        try? formView.addGroup(Former.group()
//            .header(Former.label().text("どこで◯◯を知りましたか？"))
//            .add(Former.label("prWayLabel")
//                .accessoryType(.disclosureIndicator)
//                .onSelect({ (control) in
//                    if self.form.field("prWay")?.value != nil {
//                        self.form.field("prWay")?.value = nil
//                    } else {
//                        self.form.field("prWay")?.value = "TestValue"
//                    }
//
//                }))
//            .footer(Former.label().text("利用規約にを確認し、同意しました。"))
//        )
        
//        let group = Form.group()
//            .add(Form.vertical()
//                .add(Form.textView("textView").placeholder("Enter some text").onChange({(control, string) in
//                    guard let limitLabel = self.formView.control("testLimit") as? FormLabelControl else { return }
//
//                    limitLabel.text("\(string?.count ?? 0)/100")
//                }).inlineValidators([FormMaxLengthValidator(maxLength: 50, message: "Max length is 50 characters")]))
//                .add(Form.label("testLimit").text("0/100").textHorizontalAlignment(.right)))
//
//
//        do {
//            try formView.addGroup(group)
//        } catch {
//            print("error: \(error)")
//        }
//
//
//        try? formView.addGroup(Form.group()
//            .add(Form.label("prWay")
//                .text("選択してください")
//                .accessoryType(.disclosureIndicator)
//                .onSelect({(control) in
//            }))
//        )
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
//            guard let control = self.formView.control("test1") as? FormLabelControl else { return }
//            control.text = "Test\ntest\ntest\ntest"

            guard let field = self.form.field("test") else { return }

            if let `value` = field.value as? Bool {
                field.value = !value
            } else {
                field.value = true
            }

        }))
        
//        actionSheet.addAction(UIAlertAction(title: "Test", style: .default, handler: { [weak self] (action) in
//            guard let `self` = self else { return }
//            guard let group = self.formView.storedGroups.first else { return }
//            guard let header = group.header as? FormHeaderFooterContainer else { return }
//            guard let headerView = header.linkedView as? FormHeaderFooterContainerView else { return }
//
//            print("ddd: \(headerView)\n\(headerView.contentView.subviews)")
//
//        }))
        
        actionSheet.addAction(UIAlertAction(title: "Validate", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }
            
            let (success, message) = self.formView.validate()
            if success {
                print("Validation: OK")
            } else {
                print("Validation Error: \(message ?? "Unknown")")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Reload", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }
            
            self.formView.reloadData()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }

}

