//
//  FormBadgeLabelControl.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/18.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

protocol FormStackControlElementDelegate {
    
    func updateControl()
    func buildLayout()
    
}

protocol FormStackControlElement {
    
    var isMain: Bool { get }
    var name: String { get }
    var stackDelegate: FormStackControlElementDelegate? { get set }
    
    func prepareStackDelegate(delegate: FormStackControlElementDelegate)

}

protocol FormLabelStackControlElementDelegate {
    
    func labelDidChanged(label: FormLabelStackControlElement)
    
}

open class FormLabelStackControlElement: ExtendedLabel, FormStackControlElement {
    
    let isMain: Bool
    let name: String
    var stackDelegate: FormStackControlElementDelegate?
    var labelDelegate: FormLabelStackControlElementDelegate?
    
    open override var text: String? {
        didSet {
            stackDelegate?.updateControl()
            labelDelegate?.labelDidChanged(label: self)
        }
    }
    
    open override var attributedText: NSAttributedString? {
        didSet {
            stackDelegate?.updateControl()
            labelDelegate?.labelDidChanged(label: self)
        }
    }
    
    private var observations: [NSKeyValueObservation] = []
    
    public override init(frame: CGRect) {
        fatalError("Use init()")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init(name: String = UUID().uuidString,
         _ text: String? = nil,
         textVerticalAlignment: ExtendedLabel.TextVerticalAlignment = .center,
         textHorizontalAlignment: NSTextAlignment = .left,
         isMain: Bool = false
        )
    {
        self.name = name
        self.isMain = isMain
        
        super.init(frame: CGRect.zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.numberOfLines = 1
        self.textVerticalAlignment = textVerticalAlignment
        self.textAlignment = textHorizontalAlignment
        self.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)

//        observations.append(observe(
//            \.text,
//            options: [.new]
//        ) { [weak self] object, change in
//
//            self?.stackDelegate?.updateControl()
//
//        })
//
//        observations.append(observe(
//            \.attributedText,
//            options: [.new]
//        ) { [weak self] object, change in
//
//            self?.stackDelegate?.updateControl()
//
//        })
        
    }
    
    func prepareStackDelegate(delegate: FormStackControlElementDelegate) {
        stackDelegate = delegate
    }
    
}

open class FormBadgeStackControlElement: FormLabelStackControlElement {
 
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init(name: String = UUID().uuidString,
         _ text: String? = nil,
         color: UIColor = UIColor.red,
         cornerRadius: CGFloat = 5,
         inserts: UIEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4),
         textVerticalAlignment: ExtendedLabel.TextVerticalAlignment = .center,
         textHorizontalAlignment: NSTextAlignment = .left,
         isMain: Bool = false
        )
    {
        super.init(name: name, text, textVerticalAlignment: textVerticalAlignment, textHorizontalAlignment: textHorizontalAlignment, isMain: isMain)
        
        self.numberOfLines = 0
        self.insets = inserts
        self.backgroundRectColor = color
        self.backgroundRectCornerRadius = cornerRadius
        
    }
    
}

open class FormTextFieldStackControlElement: UITextField, FormStackControlElement {
    
    let isMain: Bool
    let name: String
    var stackDelegate: FormStackControlElementDelegate?
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init(name: String = UUID().uuidString,
         _ text: String? = nil,
         placeholder: String? = nil,
         isMultiline: Bool = false,
         isMain: Bool = false
        )
    {
        self.name = name
        self.isMain = isMain
        
        super.init(frame: CGRect.zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.placeholder = placeholder
        self.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
    }
    
    func prepareStackDelegate(delegate: FormStackControlElementDelegate) {
        stackDelegate = delegate
    }
    
//    open override func onTextDidChange(notification: Notification) {
//        super.onTextDidChange(notification: notification)
//
//        let size = self.bounds.size
//        let newSize = self.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
//
//        // Resize the cell only when cell's size is changed
//        if size.height != newSize.height {
//            self.stackDelegate?.updateControl()
//        }
//
//    }
    
}

open class FormTextViewStackControlElement: ExtendedTextView, FormStackControlElement {
    
    let isMain: Bool
    let name: String
    var stackDelegate: FormStackControlElementDelegate?
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    init(name: String = UUID().uuidString,
         _ text: String? = nil,
         placeholder: String? = nil,
         isMultiline: Bool = false,
         isMain: Bool = false
        )
    {
        self.name = name
        self.isMain = isMain
        
        super.init()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.placeholder = placeholder
        self.textContainerInset = UIEdgeInsets.zero
        self.textContainer.lineFragmentPadding = 0
        self.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        self.isScrollEnabled = false
        
    }

    func prepareStackDelegate(delegate: FormStackControlElementDelegate) {
        stackDelegate = delegate
    }
    
    open override func onTextDidChange(notification: Notification) {
        super.onTextDidChange(notification: notification)
     
        let size = self.bounds.size
        let newSize = self.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        
        // Resize the cell only when cell's size is changed
        if size.height != newSize.height {
            self.stackDelegate?.updateControl()
        }
     
    }
    
}


class FormStackControl: FormControl, FormStackControlCellDataSource, FormStackControlElementDelegate {
    
    var elements: [FormStackControlElement] = []
    
    init(name: String = UUID().uuidString, elements: [FormStackControlElement] = []) {
        super.init(name: name)
        
        precondition(elements.filter({$0.isMain}).count <= 1, "Only one element could be main")
        
        elements.forEach({$0.prepareStackDelegate(delegate: self)})
        self.elements = elements
    }

    // MARK: - Cell
    
    open override var cellClass: UITableViewCell.Type {
        return FormStackControlCell.self
    }
    
    // MARK: - Preparation
    
    open override func prepare(cell: UITableViewCell) {
        super.prepare(cell: cell)
        
        guard let `cell` = cell as? FormStackControlCell else {
            return
        }
        
        cell.dataSource = self
        
    }
    
    // MARK: - FormStackControlCellDataSource
    
    func numberOfElements() -> Int {
        return elements.count
    }
    
    func element(at index: Int) -> FormStackControlElement {
        return elements[index]
    }
    
    // MARK: - Accessories
    
    func element(by name: String) -> FormStackControlElement? {
        return elements.first(where: {$0.name == name})
    }
    
    // MARK: - FormStackControlElementDelegate
    
    func updateControl() {
        guard let formView = linkedCell?.superview?.superview as? FormView else { return }
        formView.updateControls()
    }
    
    func buildLayout() {
        guard let `linkedCell` = linkedCell as? FormStackControlCell else { return }
        linkedCell.buildLayout()
        
        updateControl()
    }
}
