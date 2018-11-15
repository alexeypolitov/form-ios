//
//  ExtendedButton.swift
//  Form
//
//  Created by Alexey Politov on 2018/10/18.
//  Copyright © 2018 Alexey Politov. All rights reserved.
//

import UIKit

open class ExtendedButton: UIButton {
    
    private var backgroundColors: [UInt: UIColor?] = [:]
    private var cornerRadius: [UInt: CGFloat] = [:]
    private var borderWidths: [UInt: CGFloat] = [:]
    private var borderColors: [UInt: UIColor?] = [:]
    
    open override var isHighlighted: Bool {
        didSet {
            updateLayout()
        }
    }
    
    open override var isEnabled: Bool {
        didSet {
            updateLayout()
        }
    }
    
    open func updateLayout() {
        updateBackgroundColors()
        updateCornerRadius()
        updateBorderWidths()
        updateBorderColors()
    }

    // MARK: - Background Color
    
    private func updateBackgroundColors() {
        backgroundColor = backgroundColors[state.rawValue] ?? backgroundColors[UIControl.State.normal.rawValue] ?? nil
    }

    func backgroundColor(for state: UIControl.State) -> UIColor? {
        return backgroundColors[state.rawValue] ?? nil
    }
    
    func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        backgroundColors[state.rawValue] = color
        updateBackgroundColors()
    }
    
    // MARK: -  Corner Radius
    
    private func updateCornerRadius() {
        layer.cornerRadius = cornerRadius[state.rawValue] ?? cornerRadius[UIControl.State.normal.rawValue] ?? 0
    }
    
    func cornerRadius(for state: UIControl.State) -> CGFloat {
        return cornerRadius[state.rawValue] ?? 0
    }
    
    func setCornerRadius(_ radius: CGFloat?, for state: UIControl.State) {
        if let `radius` = radius {
            cornerRadius[state.rawValue] = radius
        } else {
            cornerRadius.removeValue(forKey: state.rawValue)
        }
        updateCornerRadius()
    }
    
    // MARK: -  Border Width
    
    private func updateBorderWidths() {
        layer.borderWidth = borderWidths[state.rawValue] ?? borderWidths[UIControl.State.normal.rawValue] ?? 0
    }
    
    func borderWidth(for state: UIControl.State) -> CGFloat {
        return borderWidths[state.rawValue] ?? 0
    }
    
    func setBorderWidth(_ width: CGFloat?, for state: UIControl.State) {
        if let width = width {
            borderWidths[state.rawValue] = width
        } else {
            borderWidths.removeValue(forKey: state.rawValue)
        }
        updateBorderWidths()
    }
    
    // MARK: -  Border Color
    
    private func updateBorderColors() {
        layer.borderColor = (borderColors[state.rawValue] ?? borderColors[UIControl.State.normal.rawValue] ?? UIColor.clear)?.cgColor
    }
    
    func borderColor(for state: UIControl.State) -> UIColor? {
        return borderColors[state.rawValue] ?? nil
    }
    
    func setBorderColor(_ color: UIColor?, for state: UIControl.State) {
        borderColors[state.rawValue] = color
        updateBorderColors()
    }
    
}
