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
        
        try formView +++ FormViewGroup() { group in
            
            group.footer = FormViewHeaderFooterContainer() { container in
                
                container.insets = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
                container.control = FormViewBadge() { control in
                    
                    control.insets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
                    control.backgroundRectColor = UIColor(displayP3Red: 255.0 / 255.0, green: 251.0 / 255.0, blue: 226.0 / 255.0, alpha: 1)
                    control.backgroundRectBorderColor = UIColor(displayP3Red: 222.0 / 255.0, green: 216.0 / 255.0, blue: 188.0 / 255.0, alpha: 1)
                    control.backgroundRectBorderWidth = 1
                    control.textColor = UIColor(displayP3Red: 144.0 / 255.0, green: 139.0 / 255.0, blue: 76.0 / 255.0, alpha: 1)
                    control.textAlignment = .left
                    
                    control.text = "お支払いはアプリ内課金として、AppleのAppStoreよりご請求が行われます。\nなお、ご請求確認方法等につきましてはコチラをご覧ください。"
                }
                
            }
            
        }
        
//        try formView +++ FormViewGroup() { group in
//            group.header = FormViewHeaderFooterContainer() { container in
//
//                container.insets = UIEdgeInsets(top: 20, left: 16, bottom: 8, right: 16)
//                container.control = FormViewVerticalContainer() { verticalContainer in
//
//                    verticalContainer.backgroundColor = UIColor.green
//
//                    let actionButton = FormViewButton("actionButton") { control in
//                        control.setTitle("パスワードを再発行する", for: .normal)
//                        control.onAction = { _ in
//                            print("ddd 1")
//                        }
//                    }
//
//                    let toTopButton = FormViewButton() { control in
//                        control.setTitle("ログイン画面へ戻る", for: .normal)
//                        control.onAction = { _ in
//                            print("ddd 2")
//                        }
//                    }
//
//                    verticalContainer.controls = [actionButton, toTopButton]
//
//                }
//
//            }
//        }
        
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
        
        actionSheet.addAction(UIAlertAction(title: "Reload", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }
            
            self.formView.reloadData()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }

}

