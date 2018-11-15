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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Actions", style: .plain, target: self, action: #selector(self.onAction(_:)))
        
//        let control = FormStackControl("testStackControl")
//            .add(FormBadgeStackControlElement("badge")
//                .text("OK"))
//            .add(FormLabelStackControlElement("textLabel")
//                .isMain(true)
//                .text("Some label 1")
//                .numberOfLines(0))
//            .add(FormTextFieldStackControlElement("textField")
//                .text("Some text")
//                .placeholder("Some placeholder")
//                .textAlignment(.right)
//                .onDidBeginEditing({ (element) in
//                  print("ok 1")
//                })
//                .onDidEndEditing({ (element, reason) in
//                  print("ok 2")
//                }))
//            .add(FormSwitchStackControlElement("switch")
//                .isOn(true)
//                .onChange({ (element, isOn) in
//                    print("isOn: \(isOn)")
//                }))
//            .onSelect({ (control) in
//                print("did selected")
//            })
        
//        let control = FormStackControl("testStackControl")
//            .add(FormTextViewStackControlElement("textView")
//                .isMain(true)
//                .text("Some label 1")
//                .placeholder("Some placeholder")
//                .shouldChangeCharacters({ (element, string, range, changes) -> Bool in
//                    guard let `string` = string else { return true }
//                    let newString = (string as NSString).replacingCharacters(in: range, with: changes)
//                    return newString.count >= 50 ? false : true
//                }))
        
        let control = FormStackControl("testStackControl")
            .add(FormImageStackControlElement("image")
                .isMain(true)
                .image(UIImage(named: "lemur1"))
                .fixedWidth(40)
                .fixedHeigth(40))
            .add(FormLabelStackControlElement("textLabel")
                .isMain(true)
                .text("Some label 1")
                .numberOfLines(0))
        let collection = FormCollection()
            .add(FormLabelCollectionItem("label1")
                .text("Some text1")
                .insets(UIEdgeInsets(top: 50, left:0, bottom: 60, right: 0)))
            .add(FormLabelCollectionItem("label2")
                .text("Some text2"))
            .add(FormLabelCollectionItem("label3")
                .text("Some text3"))
            .add(FormLabelCollectionItem("label4")
                .text("Some text4"))

        let group = FormGroup(header: collection, [control], footer: nil)

        try? formView.addGroup(group)
//        try? formView.addControl(control)
        
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
        
        actionSheet.addAction(UIAlertAction(title: "Change textLabel", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }
            guard let item = self.formView.collectionItem(name: "label1") as? FormLabelCollectionItem else { return }
            
            item.text = "Test\ntest\ntest\ntest"
            
//            guard let control = self.formView.control(name: "testStackControl") as? FormStackControl else { return }
//            guard let element = control.element(by: "textLabel") as? FormLabelStackControlElement else { return }
//
//            element.text = "sdfdsfkldsjflkdsjfdlksjflkfdsjkfjdslkfjdslfjdslfjslfjljfdslfjdslfj"
            
//            control.formLabel.text = "Some text"
            
        }))
        
//        actionSheet.addAction(UIAlertAction(title: "Remove label", style: .default, handler: { [weak self] (action) in
//            guard let `self` = self else { return }
//            guard let control = self.formView.control(name: "textField1") as? FormTextFieldControl else { return }
//
//            control.formLabel.text = nil
//
//        }))
        
        actionSheet.addAction(UIAlertAction(title: "Reload", style: .default, handler: { [weak self] (action) in
            guard let `self` = self else { return }
            
            self.formView.reloadData()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }

}

