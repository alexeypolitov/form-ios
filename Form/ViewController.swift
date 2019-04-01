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
            +++ FormField("title") { field in
                field.validators = [
//                    Former.required("Required"),
//                    Former.maxLength(maxLength: 5, "Max len expired")
                    Former.custom(handle: { () -> Bool in
                        return self.form.field("title")?.value is String
                    }, "Custom validator error")
                ]
        }
        
        formView.bind = form
        try formView +++ FormViewGroup("testControls") { group in

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
                        imageView.image = UIImage(named: "lemur1")
                        imageView.backgroundColor = UIColor.gray

                    }

                    horizontalContainer +++ FormViewVerticalContainer() { verticalController in

                        verticalController.isMain = true
                        verticalController +++ FormViewTextField("titleTextField") { textField in
                            textField.bindName = "title"
//                            textField.backgroundColor = UIColor.purple
                            textField.placeholder = "左写真に関するタイトルを付けましょう"
                        }
                        verticalController +++ FormViewTextView() { textView in
//                            textView.backgroundColor = UIColor.yellow
//                            textView.minimumHeight = 48
                            textView.minimumHeight = 157
                            textView.placeholderLabel.backgroundColor = UIColor.yellow
                            textView.placeholder = "左写真に関する説明を書きましょう！\n250文字以内で特徴をアピールしてください。"
                            
                            textView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
                            textView.layer.borderWidth = 1.0
                            textView.layer.cornerRadius = 5
                            
                            textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
                            
                        }

                    }

                }
//                container.control = FormViewTextView() { textView in
//                    textView.backgroundColor = UIColor.yellow
//                    textView.minimumHeight = 48
//                    textView.placeholder = "左写真に関する説明を書きましょう！1234567890-1234567890-\n250文字以内で特徴をアピールしてください。"
//                }
            }

//            group +++ FormViewCellContainer() { container in
//
//                container.insets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
//                container.control = FormViewStack() { stack in
//
//                    stack.axis  = NSLayoutConstraint.Axis.horizontal
//                    stack.distribution  = UIStackView.Distribution.fillEqually
//                    stack.alignment = UIStackView.Alignment.center
//                    stack.spacing   = 16.0
//
//                    let textLabel1 = UILabel()
//                    textLabel1.backgroundColor = UIColor.yellow
////                    textLabel1.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
////                    textLabel1.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
//                    textLabel1.text  = "Hi World"
//                    textLabel1.textAlignment = .center
//
//                    let textLabel2 = UILabel()
//                    textLabel2.backgroundColor = UIColor.yellow
////                    textLabel2.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
////                    textLabel2.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
//                    textLabel2.text  = "Hi World 2"
//                    textLabel2.textAlignment = .center
//
//                    stack.addArrangedSubview(textLabel1)
//                    stack.addArrangedSubview(textLabel2)
//
//                }
//            }
        }
        
    }

    func addTest() {
        guard let group = self.formView.groups.first else {
            return
        }
        
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
                        textField.placeholder = "左写真に関するタイトルを付けましょう"
                    }
                    verticalController +++ FormViewTextView() { textView in
                        textView.minimumHeight = 48
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

    @objc func onAction(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Validate", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }

            if let (success, errorString) = self.form.field("title")?.validate() {
                print("ddd: \(errorString)")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }

}

