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
        
//        tv.estimatedRowHeight = 44.0
//        tv.rowHeight = UITableView.automaticDimension
        
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
        
        if let _ = storedGroups.first(where: { (group) -> Bool in
            
            if let _ = group.controls.first(where: {$0.name == name}) {
                return true
            } else {
                return false
            }
            
        }) {
            return true
        } else {
            return false
        }
        
    }
    
    func addControl(_ control: FormControl, inGroup group: FormGroup? = nil) throws {
        
        if isControlNameDuplicate(name: control.name) {
            throw FormViewError.controlDuplication(name: control.name)
        }

        if let `group` = group {
            group.controls.append(control)
        } else if let `group` = storedGroups.last as? FormDefaultGroup {
            group.controls.append(control)
        } else {
            storedGroups.append(FormDefaultGroup([control]))
        }

        register(control.cellClass)
        tableView?.reloadData()
    
    }
    
    func addGroup(_ group: FormGroup) throws {
        
        if let collection = group.headerCollection {
            registerHeaderFooter(collection.viewClass)
        }
        if let collection = group.footerCollection {
            registerHeaderFooter(collection.viewClass)
        }
        
        try group.controls.forEach { (control) in
            
            if isControlNameDuplicate(name: control.name) {
                throw FormViewError.controlDuplication(name: control.name)
            }
            
            register(control.cellClass)
        }
        storedGroups.append(group)
        
        tableView?.reloadData()
        
    }
    
    func addControls(_ controls: [FormControl], inGroup group: FormGroup? = nil) throws {
        
        if let `group` = group {
            try controls.forEach { (control) in
                try addControl(control, inGroup: group)
            }
            
            tableView?.reloadData()
        } else if let `group` = storedGroups.last as? FormDefaultGroup {
            try addControls(controls, inGroup: group)
        } else {
            let `group` = FormDefaultGroup()
            storedGroups.append(group)
            
            try addControls(controls, inGroup: group)
        }

    }
    
    func control(name: String) -> FormControl? {
        
        for group in storedGroups {
            if let control = group.controls.first(where: {$0.name == name }) {
                return control
            }
        }

        return nil
    }
    
    func collection(_ name: String) -> FormHeaderFooter? {
        
        for group in storedGroups {
            if let header = group.headerCollection {
                if header.name == name {
                    return header
                }
            }
        }
        
        return nil
    }
    
    func collectionItem(name: String) -> FormCollectionItem? {
        
//        for group in storedGroups {
//            if let item = group.headerCollection?.item(name: name) {
//                return item
//            } else if let item = group.footerCollection?.item(name: name) {
//                return item
//            }
//        }
        
        return nil
    }
    
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
        return storedGroups.count > 0 ? storedGroups[section].controls.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let control = storedGroups[indexPath.section].controls [indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: control.cellClass), for: indexPath)

        if let `control` = control as? FormControlSelectable {
            cell.selectionStyle = control.selectionStyle
            cell.accessoryType = control.accessoryType
        } else {
            cell.selectionStyle = .none
            cell.accessoryType = .none
        }
        
        control.prepare(cell: cell)

        return cell
    }
}

extension FormView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if storedGroups.count > 0, let collection = storedGroups[section].headerCollection {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: collection.viewClass)) as! FormHeaderFooterView
            collection.prepare(headerView)
//            print("\(headerView.contentView.constraints)")
            return headerView
        }
        return nil
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if storedGroups.count > 0, let collection = storedGroups[section].headerCollection {
//            return collection.height(maxWidth: tableView.frame.width)
//        }
//        return 0
//    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if storedGroups.count > 0, let collection = storedGroups[section].footerCollection {
            let collectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: collection.viewClass)) as! FormCollectionView
            collection.prepare(collectionView: collectionView)
            
            return collectionView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if storedGroups.count > 0, let collection = storedGroups[section].footerCollection {
            return collection.height(maxWidth: tableView.frame.width)
        }
        return 0
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return storedGroups[indexPath.section].controls [indexPath.row].height(maxWidth: tableView.frame.width)
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let control = storedGroups[indexPath.section].controls [indexPath.row]
        
        if let `control` = control as? FormControlSelectable {
            control.formControlOnSelect()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
