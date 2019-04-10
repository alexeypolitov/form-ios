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
            
//            group.header = FormViewHeaderFooterContainer() { container in
//
//                container.insets = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
//                let badge = FormViewBadge() { control in
//                    control.insets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
//                    control.backgroundColor = UIColor(displayP3Red: 255.0 / 255.0, green: 251.0 / 255.0, blue: 226.0 / 255.0, alpha: 1)
//                    control.borderColor = UIColor(displayP3Red: 222.0 / 255.0, green: 216.0 / 255.0, blue: 188.0 / 255.0, alpha: 1).cgColor
//                    control.borderWidth = 1
//                    control.cornerRadius = 15
//                    control.textColor = UIColor(displayP3Red: 144.0 / 255.0, green: 139.0 / 255.0, blue: 76.0 / 255.0, alpha: 1)
//                    control.textAlignment = .left
//                    control.numberOfLines = 0
//                    control.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 3)
//
//                    control.text = "一旦ご利用を停止する場合（今後また使うかもしれない場合）は、\n「無料お試しプランに戻す」をご選択ください。\n※ご解約に関する詳細はコチラ"
//                }
//
//                container.control = badge
//
//            }
            
            group +++ FormViewCellContainer() { container in
                
                container.insets = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
                container.control = FormViewHorizontalContainer() { horizontalContainer in
                    
                    horizontalContainer +++ FormViewBadge() { badge in
                        badge.backgroundColor = UIColor(displayP3Red: 100.0 / 255.0, green: 200.0 / 255.0, blue: 227.0 / 255.0, alpha: 1.0)
//                        badge.textColor = UIColor.white
//                        badge.isMain = true
//                        badge.numberOfLines = 1
                        badge.text = "yyy"
                    }
                    
                    horizontalContainer +++ FormViewLabel() { label in
                        label.isMain = true
//                        label.numberOfLines = 0
                        label.text = "Some title"
                    }
                    
                    horizontalContainer +++ FormViewLabel() { label in
                        label.textColor = UIColor(displayP3Red: 0, green: 88.0 / 255.0, blue: 1, alpha: 1.0)
                        label.text = "詳細"
                    }
                    
                }
                
                
            }
            
        }
        
    }

    @objc func onAction(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Validate", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }

            if let preview = self.formView.control("preview") as? ProductSpecCollectionView {
//                preview.items = [ProductSpecCollectionViewItem(title: "test1test2test3", detail: "test")]
                preview.items = [
                    ProductSpecCollectionViewItem(title: "test", detail: "test1test2test3test4test5test6test7test8test9test10test11test12"),
                    ProductSpecCollectionViewItem(title: "test", detail: "test1test2test3test4test5test6test7test8test9test10test11test12")]
            }
            self.formView.reloadGroup(name: "testGroup")
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }

}

