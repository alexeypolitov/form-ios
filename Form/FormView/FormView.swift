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

class FormView: UIView {
    
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
        
        register(UITableViewCell.self)
        
    }
    
    private func register(_ cellClass: AnyClass) {
        let reuseIdentifier = String(describing: cellClass.self)
        
        if let _ = registredIdentifiers[reuseIdentifier] {
            // do nothing
        } else {
            tableView?.register(cellClass, forCellReuseIdentifier: reuseIdentifier)
            registredIdentifiers[reuseIdentifier] = cellClass
        }
    }
    
    private func registerHeaderFooter(_ viewClass: AnyClass) {
        let reuseIdentifier = String(describing: viewClass.self)
        
        if let _ = registredIdentifiers[reuseIdentifier] {
            // do nothing
        } else {
            tableView?.register(viewClass, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
            registredIdentifiers[reuseIdentifier] = viewClass
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
        
        if let collection = group.header {
            registerHeaderFooter(collection.viewClass)
        }
        if let collection = group.footer {
            registerHeaderFooter(collection.viewClass)
        }
        
        // Check duplications

        try group.rows.forEach { (row) in

            if isControlNameDuplicate(name: row.name) {
                throw FormViewError.controlDuplication(name: row.name)
            }

            register(row.viewClass)
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
            if let header = group.header as? FormSearchable {
                if let control = header.control(name) {
                    return control
                }
            }
            
            for row in group.rows {
                if let `row` = row as? FormSearchable {
                    if let control = row.control(name) {
                        return control
                    }
                }
                
            }

            if let footer = group.footer as? FormSearchable {
                if let control = footer.control(name) {
                    return control
                }
            }
        }

        return nil
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
    
    func removeControl(name: String) {
//        guard let index = storedControls.firstIndex(where: {$0.name == name}) else {
//            return
//        }
//
//        storedControls.remove(at: index)
//        tableView?.reloadData()
    }
    
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

extension FormView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return storedGroups.count > 0 ? storedGroups.count : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedGroups.count > 0 ? storedGroups[section].rows.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = storedGroups[indexPath.section].rows [indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: row.viewClass), for: indexPath) as! FormCellView

        if let row = row as? FormCellSelectable {
            cell.selectionStyle = row.selectionStyle
            cell.accessoryType = row.accessoryType
        } else {
            cell.selectionStyle = .none
            cell.accessoryType = .none
        }
        
        row.prepare(cell)

        return cell
    }
}

extension FormView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if storedGroups.count > 0, let collection = storedGroups[section].header {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: collection.viewClass)) as! FormHeaderFooterView
            collection.prepare(headerView)
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if storedGroups.count > 0, let collection = storedGroups[section].footer {
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: collection.viewClass)) as! FormHeaderFooterView
            collection.prepare(footerView)
            return footerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = storedGroups[indexPath.section].rows[indexPath.row]
        
        if let row = row as? FormCellSelectable {
            row.formCellOnSelect()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
