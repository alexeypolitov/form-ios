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
                .inlineValidator(Former.maxLength(maxLength: 20, "SignUp.Name.Validation.BetweedLength.Error")))
//                .onChange(controls: ["testLabel"], { (value, status) in
////                    print("test: \(value) - \(status)")
//                    guard let control = self.formView.control("testLabel") as? FormLabelControl else { return }
//
//                    let _ = control.text("dddddd")
//                }))
            .add(Form.field("email"))
            .add(Form.field("password"))
            .add(Form.field("prWay").onChange(controls: ["prWayLabel"], { (value, status) in
                guard let control = self.formView.control("prWayLabel") as? FormLabelControl else { return }
                if value != nil {
                    let _ = control.text("Value \(value!)")
                } else {
                    let _ = control.text("選択してください")
                }
            }))
        
        // FormView
        
        let _ = formView.bind(form)
        try? formView.addGroup(Former.group()
            .header(Former.label("testLabel").text("1以下をご入力ください\n\n").numberOfLines(0))
            .add(Former.textField("nameTextField").placeholder("1氏名"))
            .add(Former.textField("emailTextField").placeholder("1メールアドレス"))
            .add(Former.textField("passwordTextField").placeholder("1パスワード（半角英数字6字以上）"))
            .footer(Former.label().text("1パスワードは忘れないようにメモしましょう！"))
        )
        
        try? formView.addGroup(Former.group()
            .header(Former.label("testLabel").text("2以下をご入力ください"))
            .add(Former.textField("nameTextField").placeholder("2氏名"))
            .add(Former.textField("emailTextField").placeholder("2メールアドレス"))
            .add(Former.textField("passwordTextField").placeholder("2パスワード（半角英数字6字以上）"))
            .footer(Former.label().text("2パスワードは忘れないようにメモしましょう！"))
        )
        
        try? formView.addGroup(Former.group()
            .header(Former.label("testLabel").text("3以下をご入力ください"))
            .add(Former.textField("nameTextField").placeholder("3氏名"))
            .add(Former.textField("emailTextField").placeholder("3メールアドレス"))
            .add(Former.textField("passwordTextField").placeholder("3パスワード（半角英数字6字以上）"))
            .footer(Former.label().text("3パスワードは忘れないようにメモしましょう！"))
        )

        try? formView.addGroup(Former.group()
            .header(Former.label("testLabel").text("4以下をご入力ください"))
            .add(Former.textField("nameTextField").placeholder("4氏名"))
            .add(Former.textField("emailTextField").placeholder("4メールアドレス"))
            .add(Former.textField("passwordTextField").placeholder("4パスワード（半角英数字6字以上）"))
            .footer(Former.label().text("4パスワードは忘れないようにメモしましょう！"))
        )

        try? formView.addGroup(Former.group()
            .header(Former.label("testLabel").text("5以下をご入力ください"))
            .add(Former.textField("nameTextField").placeholder("5氏名"))
            .add(Former.textField("emailTextField").placeholder("5メールアドレス"))
            .add(Former.textField("passwordTextField").placeholder("5パスワード（半角英数字6字以上）"))
            .footer(Former.label().text("5パスワードは忘れないようにメモしましょう！"))
        )
        try? formView.addGroup(Former.group()
            .header(Former.label("testLabel").text("6以下をご入力ください"))
            .add(Former.textField("nameTextField").placeholder("6氏名"))
            .add(Former.textField("emailTextField").placeholder("6メールアドレス"))
            .add(Former.textField("passwordTextField").placeholder("6パスワード（半角英数字6字以上）"))
            .footer(Former.label().text("6パスワードは忘れないようにメモしましょう！"))
        )

        try? formView.addGroup(Former.group()
            .header(Former.label("testLabel").text("7以下をご入力ください"))
            .add(Former.textField("nameTextField").placeholder("7氏名"))
            .add(Former.textField("emailTextField").placeholder("7メールアドレス"))
            .add(Former.textField("passwordTextField").placeholder("7パスワード（半角英数字6字以上）"))
            .footer(Former.label().text("7パスワードは忘れないようにメモしましょう！"))
        )
        
        try? formView.addGroup(Former.group()
            .header(Former.label().text("どこで◯◯を知りましたか？"))
            .add(Former.label("prWayLabel")
                .accessoryType(.disclosureIndicator)
                .onSelect({ (control) in
                    if self.form.field("prWay")?.value != nil {
                        self.form.field("prWay")?.value = nil
                    } else {
                        self.form.field("prWay")?.value = "TestValue"
                    }

                }))
            .footer(Former.label().text("利用規約にを確認し、同意しました。"))
        )
        
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
//                print("dddd")
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
            
            guard let field = self.form.field("name") else { return }
            
            field.value = "test"
            
        }))
        
//        actionSheet.addAction(UIAlertAction(title: "Remove label", style: .default, handler: { [weak self] (action) in
//            guard let `self` = self else { return }
//            guard let control = self.formView.control(name: "textField1") as? FormTextFieldControl else { return }
//
//            control.formLabel.text = nil
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

