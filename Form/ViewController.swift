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
    
    var item: ProductSpecCollectionViewItem = ProductSpecCollectionViewItem(title: "項目名", detail: "項目に関する説明")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Actions", style: .plain, target: self, action: #selector(self.onAction(_:)))
        
        buildForm()
        do {
            try buildFormView()
        } catch {
            print("error: \(error)")
        }

    }
    
    func buildForm() {
        
        form +++ FormField("title") { field in
            field.onChange = { _ in
                if let value = field.value as? String {
                    self.item.title = value.count > 0 ? value : "項目名"
                } else {
                    self.item.title = "項目名"
                }
                                
                if let collection = self.formView.control("preview") as? ProductSpecCollectionView {
                    collection.items = [self.item, self.item]
                }
            }
        }
        form +++ FormField("detail") { field in
            field.onChange = { _ in
                if let value = field.value as? String {
                    self.item.detail = value.count > 0 ? value : "項目に関する説明"
                } else {
                    self.item.detail = "項目に関する説明"
                }
                
                if let collection = self.formView.control("preview") as? ProductSpecCollectionView {
                    collection.items = [self.item, self.item]
                }
            }
        }
        
    }
    
    func buildFormView() throws {
        
        formView.bind = form
        
        try formView +++ FormViewGroup() { group in
            
            group.header = Former.emptyHeaderFooter()
            
            group +++ FormViewCellContainer() { container in
                
                container.insets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
                container.control = FormViewTextField("titleTextField", { textField in
                    textField.bindName = "title"
                    textField.placeholder = "Title"
                })
                
            }

            group +++ FormViewCellContainer() { container in
                
                container.insets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
                container.control = FormViewTextView("descriptionTextView", { (textView) in
                    textView.bindName = "detail"
                    textView.placeholder = "Detail"
                    textView.minimumHeight = 60
                })
                
            }
            
            group.footer = Former.emptyHeaderFooter()
            
        }
        
        try formView +++ FormViewGroup("previewGroup") { group in
            group.header = FormViewHeaderFooterContainer() { container in
                
                container.insets = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)
                container.control = FormViewLabel() { control in
                    control.font = UIFont.systemFont(ofSize: 12)
                    control.textColor = UIColor.black
                    control.textAlignment = .left
                    control.text = "完成イメージ"
                }
                
            }
            

            group.footer = FormViewHeaderFooterContainer() { container in

//                container.insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
                container.control = ProductSpecCollectionView("preview") { collection in
                    collection.items = [self.item, self.item]
                }

            }
            
        }
        
        
    }


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

