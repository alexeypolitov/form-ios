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
            
            group +++ FormViewCellContainer() { container in
                
                container.insets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
                container.control = FormViewHorizontalContainer() { horizontalContainer in

                    horizontalContainer +++ FormViewButton() { button in
                        button.setTitle("+", for: .normal)
                        button.setTitleColor(UIColor.black, for: .normal)
                    }

                    horizontalContainer +++ FormViewImageView() { imageView in

                        imageView.fixedWidth = 50
                        imageView.fixedHeigth = 50
                        imageView.backgroundColor = UIColor.gray

                    }

                    horizontalContainer +++ FormViewVerticalContainer() { verticalController in

                        verticalController.isMain = true
                        verticalController +++ FormViewTextField() { textField in
                            textField.backgroundColor = UIColor.purple
                            textField.placeholder = "左写真に関するタイトルを付けましょう"
                        }
                        verticalController +++ FormViewTextView() { textView in
                            textView.backgroundColor = UIColor.yellow
//                            textView.minimumHeight = 48
                            textView.placeholder = "左写真に関する説明を書きましょう！\n250文字以内で特徴をアピールしてください。"
                        }

                    }

                }
//                container.control = FormViewTextView() { textView in
//                    textView.backgroundColor = UIColor.yellow
//                    textView.minimumHeight = 48
//                    textView.placeholder = "左写真に関する説明を書きましょう！1234567890-1234567890-\n250文字以内で特徴をアピールしてください。"
//                }
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
            
//            self.formView.reloadData()
            self.formView.hideInputSource()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }

}

