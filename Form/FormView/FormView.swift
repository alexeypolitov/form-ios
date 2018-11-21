//
//  FormView.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/16.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

enum FormViewError: Error {
    case controlDuplication(name: String)
}

class FormView: UIView, FormViewBindDelegate, FormBindDelegate {
    
    fileprivate var tableView: UITableView?
    fileprivate var storedGroups: [FormGroup] = []
    
    fileprivate var registredIdentifiers: [String: AnyClass] = [:]
    
    override func awakeFromNib() {
        
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        
        addSubview(tv)
        
        tv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        tableView = tv
        
        register(UITableViewCell.self, name: String(describing: UITableViewCell.self))
        
    }
    
    private func register(_ cellClass: AnyClass, name: String? = nil) {
        let reuseIdentifier = String(describing: cellClass.self)
        
        if let _ = registredIdentifiers[reuseIdentifier] {
            // do nothing
        } else {
            tableView?.register(cellClass, forCellReuseIdentifier: reuseIdentifier)
            registredIdentifiers[reuseIdentifier] = cellClass
        }
    }
    
    private func registerHeaderFooter(_ viewClass: AnyClass, name: String? = nil) {
        let reuseIdentifier = String(describing: viewClass.self)
        
        if let _ = registredIdentifiers[reuseIdentifier] {
            // do nothing
        } else {
            tableView?.register(viewClass, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
            registredIdentifiers[reuseIdentifier] = viewClass
        }
    }
    
    // MARK: - Binding
    
    private var bindForm: Form?
    
    func bind(_ form: Form?) -> FormView {
        self.bindForm = form
        self.bindForm?.bindDelegate = self
        return self
    }
    
    func bindValueChanged(control: FormControllable, bindName: String, value: Any?) {
        guard let field = bindForm?.field(bindName) else { return }
        field.setValueFromFormView(value, controlName: control.name)
    }
    
    func bindValue(_ bindName: String) -> Any? {
        precondition(bindForm != nil, "Form has not binding, but bindValue did called")        
        guard let field = bindForm?.field(bindName) else { return nil }
        return field.value
    }
    
    // MARK: - FormBindDelegate
    
    func formBindValueChanged(bindName: String, value: Any?, exclude: [String]) {
        let constols = bindableControls(bindName)
        for control in constols {
            if let `control` = control as? FormControllable, let _ = exclude.first(where: {$0 == control.name}) { continue }
            control.refreshBindValue()
        }
    }
    
}

extension FormView {
    
    private func isControlNameDuplicate(name: String) -> Bool {
        
        if let _ = control(name) {
            return true
        } else {
            return false
        }
        
    }
    
//    func addControl(_ control: FormControl, inGroup group: FormGroup? = nil) throws {
//
//        if isControlNameDuplicate(name: control.name) {
//            throw FormViewError.controlDuplication(name: control.name)
//        }
//
//        if let `group` = group {
//            group.controls.append(control)
//        } else if let `group` = storedGroups.last as? FormDefaultGroup {
//            group.controls.append(control)
//        } else {
//            storedGroups.append(FormDefaultGroup([control]))
//        }
//
//        register(control.cellClass)
//        tableView?.reloadData()
//
//    }
    
    func addGroup(_ group: FormGroup) throws {
        
        if let container = group.header {
            registerHeaderFooter(container.viewClass, name: container.name)
//            registerHeaderFooter(header.viewClass)
        }
        if let container = group.footer {
            registerHeaderFooter(container.viewClass, name: container.name)
//            registerHeaderFooter(collection.viewClass)
        }
        
        // Check duplications

        try group.rows.forEach { (row) in

            if isControlNameDuplicate(name: row.name) {
                throw FormViewError.controlDuplication(name: row.name)
            }

            register(row.viewClass, name: row.name)
//            register(row.viewClass)
        }
        
        storedGroups.append(group)
        
        tableView?.reloadData()
        
    }
    
//    func addControls(_ controls: [FormControl], inGroup group: FormGroup? = nil) throws {
//
//        if let `group` = group {
//            try controls.forEach { (control) in
//                try addControl(control, inGroup: group)
//            }
//
//            tableView?.reloadData()
//        } else if let `group` = storedGroups.last as? FormDefaultGroup {
//            try addControls(controls, inGroup: group)
//        } else {
//            let `group` = FormDefaultGroup()
//            storedGroups.append(group)
//
//            try addControls(controls, inGroup: group)
//        }
//
//    }
    
    func control(_ name: String) -> FormControllable? {
        
        for group in storedGroups {
            if let control = group.control(name) {
                return control
            }
        }

        return nil
    }
    
    func bindableControls(_ bindName: String) -> [FormBindable] {
        var list: [FormBindable] = []
        for group in storedGroups {
            list.append(contentsOf: group.bindableControls(bindName))
        }
        return list
    }
    
//    func collection(_ name: String) -> FormHeaderFooter? {
//
//        for group in storedGroups {
//            if let header = group.header {
//                if header.name == name {
//                    return header
//                }
//            }
//        }
//
//        return nil
//    }
    
//    func collectionItem(name: String) -> FormCollectionItem? {
//
////        for group in storedGroups {
////            if let item = group.headerCollection?.item(name: name) {
////                return item
////            } else if let item = group.footerCollection?.item(name: name) {
////                return item
////            }
////        }
//
//        return nil
//    }
    
//    func removeControl(name: String) {
////        guard let index = storedControls.firstIndex(where: {$0.name == name}) else {
////            return
////        }
////
////        storedControls.remove(at: index)
////        tableView?.reloadData()
//    }
    
    func removeAllControls() {
        storedGroups.removeAll()
        tableView?.reloadData()
    }
    
    func updateControls() {
        UIView.setAnimationsEnabled(false)
        tableView?.beginUpdates()
        tableView?.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
    
    func reloadData() {
        tableView?.reloadData()
    }
    
}

extension FormView {
    
    func validate() -> (Bool, String?) {
        
        for group in storedGroups {
            let (success, message) = group.validate()
            if !success {
                return (success, message)
            }
        }
        
        return (true, nil)
    }
    
}

extension FormView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return storedGroups.count > 0 ? storedGroups.count : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedGroups.count > 0 ? storedGroups[section].rows.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = storedGroups[indexPath.section].rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: row.viewClass), for: indexPath) as! FormCellView
        
        if let row = row as? FormCellSelectable {
            cell.selectionStyle = row.selectionStyle ?? .none
            cell.accessoryType = row.accessoryType ?? .none
        } else {
            cell.selectionStyle = .none
            cell.accessoryType = .none
        }
        
        row.prepare(cell, formView: self)        

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = storedGroups[indexPath.section].rows[indexPath.row]
        row.processed()
    }
}

extension FormView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if storedGroups.count > 0, let header = storedGroups[section].header {            
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: header.viewClass)) as! FormHeaderFooterView
            header.prepare(headerView, formView: self)
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if storedGroups.count > 0, let header = storedGroups[section].header {
            header.processed()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if storedGroups.count > 0, let footer = storedGroups[section].footer {
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: footer.viewClass)) as! FormHeaderFooterView
            footer.prepare(footerView, formView: self)
            return footerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if storedGroups.count > 0, let footer = storedGroups[section].footer {
            footer.processed()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = storedGroups[indexPath.section].rows[indexPath.row]
        
        if let row = row as? FormCellSelectable {
            row.formCellOnSelect()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
