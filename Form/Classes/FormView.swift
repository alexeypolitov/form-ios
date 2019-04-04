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

open class FormView: UIView, FormViewBindDelegate, FormBindDelegate {
    
    public var tableView: UITableView?
    private var visibleGroups: [FormViewGroup] = []
    public var groups: [FormViewGroup] = []
    fileprivate var registredIdentifiers: [String: AnyClass] = [:]
    fileprivate var registredNames: [String] = []
    
    public init(_ style: UITableView.Style = .grouped) {
        super.init(frame: CGRect.zero)
        prepareView(style)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }
    
    public func prepareView(_ style: UITableView.Style = .grouped) {
        let tv = UITableView(frame: .zero, style: style)
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
    
    private func registerName(_ name: String) throws {
        if let _ = registredNames.first(where: {$0 == name}) {
            throw FormViewError.controlDuplication(name: name)
        }
        registredNames.append(name)
    }
    
    // MARK: - Binding
    
    public var bind: Form? {
        didSet {
            bind?.bindDelegate = self
        }
    }
    
    open func bindValueChanged(control: FormViewControllable, bindName: String, value: Any?) {
        guard let field = bind?.field(bindName) else { return }
        field.setValueFromFormView(value, controlName: control.name)
    }
    
    open func bindValue(_ bindName: String) -> Any? {
//        precondition(bind != nil, "Form has not binding, but bindValue did called")
        guard let field = bind?.field(bindName) else { return nil }
        return field.value
    }
    
    // MARK: - FormBindDelegate
    
    open func formBindValueChanged(bindName: String, value: Any?, exclude: [String]) {
        let constols = bindableControls(bindName)
        for control in constols {
            if let `control` = control as? FormViewControllable, let _ = exclude.first(where: {$0 == control.name}) { continue }
            control.refreshBindValue()
        }
    }
    
}

extension FormView {
    
    open func addGroup(_ group: FormViewGroup) throws {
        
        if let container = group.header {
            try registerName(container.name)
            if let `containerable` = container as? FormViewContainerable {
                for controlName in containerable.controlsNames() {
                    try registerName(controlName)
                }
            }
            registerHeaderFooter(container.viewClass, name: container.name)
        }
        if let container = group.footer {
            try registerName(container.name)
            if let `containerable` = container as? FormViewContainerable {
                for controlName in containerable.controlsNames() {
                    try registerName(controlName)
                }
            }
            registerHeaderFooter(container.viewClass, name: container.name)
        }
        
        // Check duplications

        for row in group.rows {
            try registerName(row.name)
            if let `containerable` = row as? FormViewContainerable {
                for controlName in containerable.controlsNames() {
                    try registerName(controlName)
                }
            }
            register(row.viewClass, name: row.name)
        }
        
        // Link to FromView
        group.formView = self
        groups.append(group)
        
        prepareVisibleGroups()
        tableView?.reloadData()
        
    }
    
    open func insertGroup(_ group: FormViewGroup, at index: Int) throws {
        
        if let container = group.header {
            try registerName(container.name)
            if let `containerable` = container as? FormViewContainerable {
                for controlName in containerable.controlsNames() {
                    try registerName(controlName)
                }
            }
            registerHeaderFooter(container.viewClass, name: container.name)
        }
        if let container = group.footer {
            try registerName(container.name)
            if let `containerable` = container as? FormViewContainerable {
                for controlName in containerable.controlsNames() {
                    try registerName(controlName)
                }
            }
            registerHeaderFooter(container.viewClass, name: container.name)
        }
        
        // Check duplications
        
        for row in group.rows {
            try registerName(row.name)
            if let `containerable` = row as? FormViewContainerable {
                for controlName in containerable.controlsNames() {
                    try registerName(controlName)
                }
            }
            register(row.viewClass, name: row.name)
        }
        
        // Link to FromView
        group.formView = self
        groups.insert(group, at: index)
        
        prepareVisibleGroups()
        tableView?.reloadData()
        
    }
    
    open func control(_ name: String) -> FormViewControllable? {
        
        for group in groups {
            if let control = group.control(name) {
                return control
            }
        }

        return nil
    }
    
    open func group(_ name: String) -> FormViewGroup? {
        
        for group in groups {
            if group.name == name {
                return group
            }
        }
        
        return nil
    }
    
    open func bindableControls(_ bindName: String) -> [FormViewBindable] {
        var list: [FormViewBindable] = []
        for group in groups {
            list.append(contentsOf: group.bindableControls(bindName))
        }
        return list
    }
    
    open func removeRow(by name: String) {
        for group in groups {
            group.rows.removeAll(where: {$0.name == name})
        }
        reloadData()
    }
    
    open func removeAllControls() {
        groups.removeAll()
        reloadData()
    }
    
    open func updateControls() {
        UIView.setAnimationsEnabled(false)
        tableView?.beginUpdates()
        tableView?.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
    
    private func prepareVisibleGroups() {
        visibleGroups = []
        for group in groups {
            if !group.isHidden {
                visibleGroups.append(group)
            }
        }
    }
    
    open func reloadData() {
        prepareVisibleGroups()
        tableView?.reloadData()
    }
    
    open func reloadGroup(name: String) {
        prepareVisibleGroups()
        guard let index = visibleGroups.firstIndex(where: {$0.name == name}) else { return }
        tableView?.reloadSections(IndexSet(integer: index), with: .none)
    }
    
}

extension FormView: UITableViewDataSource {
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return visibleGroups.count > 0 ? visibleGroups.count : 1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleGroups.count > 0 ? visibleGroups[section].rows.count : 0
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = visibleGroups[indexPath.section].rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: row.viewClass), for: indexPath) as! FormViewCellView
        
        if let row = row as? FormViewCellSelectable {
            cell.selectionStyle = row.selectionStyle ?? .none
            cell.accessoryType = row.accessoryType ?? .none
        } else {
            cell.selectionStyle = .none
            cell.accessoryType = .none
        }
        
        row.prepare(cell, formView: self)        

        return cell
    }

}

extension FormView: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if visibleGroups.count > 0, let header = visibleGroups[section].header {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: header.viewClass)) as! FormViewHeaderFooterView
            header.prepare(headerView, formView: self)
            return headerView
        }
        return nil
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if visibleGroups.count > 0, let footer = visibleGroups[section].footer {
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: footer.viewClass)) as! FormViewHeaderFooterView
            footer.prepare(footerView, formView: self)
            return footerView
        }
        return nil
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = visibleGroups[indexPath.section].rows[indexPath.row]
        
        if let row = row as? FormViewCellSelectable {
            row.formCellOnSelect()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - Input Source

extension FormView {
    
    open func inputSourceWillShow(_ notification: Notification, container: Any?) {
        guard let userInfo = notification.userInfo else { return }
        
        if
            let keyboardRectValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
            
            let keyboardRect = keyboardRectValue.cgRectValue
            
            UIView.animate(withDuration: duration, animations: {
                self.tableView?.tableFooterView = UIView(frame: CGRect(origin: CGPoint.zero, size: keyboardRect.size))
            }) { (complete) in
                if let cellObject = container as? FormViewCell, let cellView = cellObject.linkedView {
                    if let indexPath = self.tableView?.indexPath(for: cellView) {
                        self.tableView?.scrollToRow(at: indexPath, at: .top, animated: true)
                    }

                }
            }
            
        }

    }
    
    open func inputSourceWillHide(_ notification: Notification) {
        self.tableView?.tableFooterView = nil
    }
    
    open func hideInputSource() {
        for group in visibleGroups {
            group.hideInputSource()
        }
    }
    
}
